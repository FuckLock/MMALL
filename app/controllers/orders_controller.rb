class OrdersController < ApplicationController
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
    order_no = RandomCode.generate_order_uuid
    shopping_carts = ShoppingCart.by_user_uuid(current_user.uuid).includes(:product)
    shopping_carts.each do |shopping_cart|
      total_money = shopping_cart.amount * shopping_cart.product.price
      current_user.orders.create!(product_id: shopping_cart.product_id, address_id: params[:order][:address_id],
                                  amount: shopping_cart.amount, total_money: total_money, order_no: order_no
                                 )  
    end
    shopping_carts.map(&:destroy!)
    redirect_to generate_pay_payments_path(order_nos: order_no)
  end

  def index
    @order_hash = {}
    Order.all.each do |order|
      @order_hash[order.order_no] ||= []
      @order_hash[order.order_no] << order
    end
    
  end

end
