class ShoppingCartsController < ApplicationController
  before_action :find_shopping_cart, only: %i[update destroy]

  def index
    fetch_home_data
    @shopping_carts = ShoppingCart.by_user_uuid(session[:user_uuid])
                                  .order('id desc').includes([product: [:main_product_image]])
  end

  def create
    # debugger
    @product = Product.where(id: params[:product_id]).includes(:main_product_image).first
    @shopping_cart = ShoppingCart.find_by product_id: params[:product_id]
    if @shopping_cart
      amount = params[:amount].to_i + @shopping_cart.amount
      @shopping_cart.update_attributes!(amount: amount)
    else
      ShoppingCart.create!(product_id: params[:product_id], amount: params[:amount],
                           user_uuid: session[:user_uuid])
    end
    render layout: false
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
