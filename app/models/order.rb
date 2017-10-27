class Order < ApplicationRecord
  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :address_id, presence: true
  validates :total_money, presence: true
  validates :amount, presence: true

  belongs_to :user
  belongs_to :address
  belongs_to :product
  belongs_to :payment

  # before_create :generate_order_no

  module OrderStatus
    INITIAL = 'initial'
    PAID = 'paid'
  end

  def paid?
    status == Order::OrderStatus::PAID
  end

  private

  # def generate_order_no

  #   self.order_no = RandomCode.generate_order_uuid
  # end
end
