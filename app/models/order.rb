# frozen_string_literal: true

class Order < ApplicationRecord
  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :address_id, presence: true
  validates :total_money, presence: true
  validates :amount, presence: true
  validates :order_no, uniqueness: true

  belongs_to :user
  belongs_to :address
  belongs_to :product
  belongs_to :payment

  before_create :gen_order_no

  module OrderStatus
    INITIAL = 'initial'
    PAID = 'paid'
  end

  def paid?
    status == Order::OrderStatus::PAID
  end

  def self.create_order_from_shopping_carts(user, address, *shopping_carts)
    shopping_carts = shopping_carts.flatten!

    orders = []
    address_attr = address.attributes.except('id', 'created_at', 'updated_at')
    order_address = user.addresses.create!(address_attr.merge(address_type: Address::AddressType::ORDER))
    shopping_carts.each do |shopping_cart|
      orders << user.orders.create!(
        product: shopping_cart.product,
        address: order_address,
        total_money: shopping_cart.amount * shopping_cart.product.price,
        amount: shopping_cart.amount
      )
    end
    shopping_carts.map(&:destroy!)
    orders
  end

  private

  def gen_order_no
    self.order_no = RandomCode.generate_order_uuid
  end
end
