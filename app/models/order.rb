class Order < ApplicationRecord

  include OrdersHelper
  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :address_id, presence: true
  validates :total_money, presence: true
  validates :amount, presence: true

  belongs_to :user
  belongs_to :address
  belongs_to :product
  belongs_to :payment

  module OrderStatus
    INITIAL = 'initial'
    PAID = 'paid'
  end

  def paid?
    status == Order::OrderStatus::PAID
  end

end
