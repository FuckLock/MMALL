class ShoppingCartsController < ApplicationController
  before_action :find_shopping_cart, only: %i[update destroy]
  layout 'home'

  def index
    # fetch_home_data
    # debugger
    @shopping_carts = ShoppingCart.by_user_uuid(session[:user_uuid])
                                  .order('id desc').includes([product: [:main_product_image]])
    @checked_carts = @shopping_carts.select{|shopping_cart| shopping_cart.select_value == 1}
    @select_booleean = @shopping_carts.collect { |shopping_cart| shopping_cart.select_value }.include?0
  end

  def create
    @product = Product.where(id: params[:shopping_cart][:product_id]).includes(:main_product_image).first
    @shopping_cart = ShoppingCart.find_by product_id: params[:shopping_cart][:product_id]
    return if session["token"] == params["authenticity_token"]
    if @shopping_cart
      amount = params[:shopping_cart][:amount].to_i + @shopping_cart.amount
      @shopping_cart.update_attributes!(amount: amount)
    else
      @shopping_cart = ShoppingCart.create!(product_id: params[:shopping_cart][:product_id], amount: params[:shopping_cart][:amount],
                           user_uuid: session[:user_uuid])
    end
    session["token"] = params["authenticity_token"]
  end

  def update
    amount = params[:amount].to_i
    amount = amount <= 0 ? 1 : amount
    @shopping_cart.update_attributes amount: amount
    redirect_to shopping_carts_path
  end

  def destroy
    # debugger
    if request.method == "POST" && @shopping_cart.length == ShoppingCart.all.length
      @shopping_cart.collect{|shopping_cart| shopping_cart.destroy}
      render template: 'shopping_carts/emptycart', layout: false
    elsif request.method == "POST" && @shopping_cart.length != ShoppingCart.all.length
      @shopping_cart.collect{|shopping_cart| shopping_cart.destroy}
      @shopping_carts = ShoppingCart.by_user_uuid(session[:user_uuid])
                                  .order('id desc').includes([product: [:main_product_image]])
      render template: 'shopping_carts/index', layout: false
    else
      @shopping_cart.destroy
      redirect_to shopping_carts_path
    end
  end

  def update_amount
    shopping_cart = ShoppingCart.find_by product_id: params[:product_id]
    shopping_cart.update_attributes!(amount: params[:amount])
  end

  def select_value
    unless params[:id]
      if params[:select_value] == "0"
        ShoppingCart.all.collect{|shopping_cart| shopping_cart.update_attributes!(select_value: 0)}
      else 
        ShoppingCart.all.collect{|shopping_cart| shopping_cart.update_attributes!(select_value: 1)}
      end
      return
    end
    @shopping_cart = find_shopping_cart
    @shopping_cart.update_attributes!(select_value: params[:select_value].to_i)
  end

  private
  def find_shopping_cart
    @shopping_cart = ShoppingCart.find params[:id]
  end
end
