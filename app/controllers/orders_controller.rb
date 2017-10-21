class OrdersController < ApplicationController
  # before_action :auth_user

  def new
    # debugger
    fetch_home_data
    # @address = Address.new
    @shopping_carts = ShoppingCart.by_user_uuid(current_user.uuid).by_select_value(1).order('id desc')
                                  .includes([product: [:main_product_image]])
    @addresses = current_user.addresses.sort{|a,b| b.selected_value <=> a.selected_value}
    @address = Address.by_select_value(1).first                                  
    render action: :new                             
  end

  def create
    shopping_carts = ShoppingCart.by_user_uuid(current_user.uuid).includes(:product)
    if shopping_carts.blank?
      redirect_to shopping_carts_path
    else
      address = current_user.addresses.find(params[:address_id])
      orders = Order.create_order_from_shopping_carts(current_user, address, shopping_carts)
      redirect_to generate_pay_payments_path(order_nos: orders.map(&:order_no).join(','))
    end
  end
end
