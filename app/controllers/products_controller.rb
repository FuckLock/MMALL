class ProductsController < ApplicationController
	layout 'home'
  def show
  	# debugger
    @categories = Category.grouped_data
    @product = Product.find(params[:id])
    @main_product_image = @product.main_product_image
    @product_images = @product.product_images.order("weight desc")
  end
end
