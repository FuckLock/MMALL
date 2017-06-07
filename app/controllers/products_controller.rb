class ProductsController < ApplicationController

	def show
		@categories = Category.grouped_data
		@product = Product.find(params[:id])
	end

end
