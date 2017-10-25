# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :user
  has_many :orders

  before_create :gen_payment_no

  module PaymentStatus
    INTITAL = 'intital'
    SUCCESS = 'sucessed'
    FAILED = 'Failed'
  end

  def success?
    status == Payment::PaymentStatus::SUCCESS
  end

  def do_success_payment!(options)
    self.transaction_no = options[:trade_no]
    self.status = Payment::PaymentStatus::SUCCESS
    self.raw_respose = options.to_json
    self.payment_at = Time.now
    save!
  end

  def do_failed_payment!(_params)
    self.transaction_no = options[:trade_no]
    self.status = Payment::PaymentStatus::FAILED
    self.raw_respose = options.to_json
    self.payment_at = Time.now
    save!
  end

  def gen_payment_no
    self.payment_no = RandomCode.generate_utoken(32)
  end

  def self.create_from_orders!(user, *orders)
    orders.flatten!
    payment = user.payments.create!(total_money: orders.sum(&:total_money))
    orders.each do |order|
      raise "order #{order.order_no} has already paid" if order.paid?
      order.payment = payment
      order.save!
    end
    payment
  end
end
