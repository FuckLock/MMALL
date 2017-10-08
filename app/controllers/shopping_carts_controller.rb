class ShoppingCartsController < ApplicationController
  before_action :find_shopping_cart, only: %i[update destroy]
  layout 'home'

  def index
    # fetch_home_data
    # debugger
    @shopping_carts = ShoppingCart.by_user_uuid(session[:user_uuid])
                                  .order('id desc').includes([product: [:main_product_image]])
  end

  def create
    @product = Product.where(id: params[:shopping_cart][:product_id]).includes(:main_product_image).first
    @shopping_cart = ShoppingCart.find_by product_id: params[:shopping_cart][:product_id]
    return if session["token"] == params["authenticity_token"]
    if @shopping_cart
      amount = params[:shopping_cart][:amount].to_i + @shopping_cart.amount
      @shopping_cart.update_attributes!(amount: amount)
    else
      ShoppingCart.create!(product_id: params[:shopping_cart][:product_id], amount: params[:shopping_cart][:amount],
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
    @shopping_cart.destroy
    redirect_to shopping_carts_path
  end

  private
  def find_shopping_cart
    @shopping_cart = ShoppingCart.find params[:id]
  end
end
