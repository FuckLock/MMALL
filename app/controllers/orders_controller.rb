class OrdersController < ApplicationController
  # before_action :auth_user
  layout 'home'

  def new                                
    Address.by_address_value(1).each{|address| address.update_attributes!(selected_value: 1)} unless Address.exists?(selected_value: 1)
    @address = Address.by_select_value(1).first
    @shopping_carts = ShoppingCart.by_user_uuid(current_user.uuid).by_select_value(1).order('id desc')
                                  .includes([product: [:main_product_image]])
    @addresses = current_user.addresses.sort{|a,b| b.selected_value <=> a.selected_value}
    render action: :new                             
  end

  def create
    orders = []
    shopping_carts = ShoppingCart.by_user_uuid(current_user.uuid).includes(:product)
    shopping_carts.each do |shopping_cart|
      total_money = shopping_cart.amount * shopping_cart.product.price
      orders << current_user.orders.create!(product_id: shopping_cart.product_id, address_id: params[:order][:address_id],
                                  amount: shopping_cart.amount, total_money: total_money
                                 )  
    end
    shopping_carts.map(&:destroy!)
    redirect_to generate_pay_payments_path(order_nos: orders.map(&:order_no).join(','))
  end

  def index
    
  end

end
