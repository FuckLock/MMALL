# frozen_string_literal: true

class ShoppingCartsController < ApplicationController
  before_action :find_shopping_cart, only: %i[update destroy]

  def index
    fetch_home_data
    @shopping_carts = ShoppingCart.by_user_uuid(session[:user_uuid])
                                  .order('id desc').includes([product: [:main_product_image]])
  end

  def create
    amount = params[:amount].to_i
    amount = amount <= 0 ? 1 : amount

    @product = Product.find params[:product_id]
    @shopping_cart = ShoppingCart.create_or_update!(user_uuid: session[:user_uuid],
                                                    product_id: params[:product_id],
                                                    amount: amount)
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
