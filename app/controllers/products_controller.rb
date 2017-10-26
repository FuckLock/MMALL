class ProductsController < ApplicationController
	layout 'home'
  def show
    @categories = Category.grouped_data
    @product = Product.find(params[:id])
    @main_product_image = @product.main_product_image
    @product_images = @product.product_images.order("weight desc")
  end

  def search
  	redirect_to root_path and return if params["search-input"].blank?
  	# 从分类来重找
  	search_value = params["search-input"].gsub(/^(\s*)|(\s*)$/, '')
  	Category.where('ancestry is not null').each do |category|
  		if category.title.include? search_value
  			redirect_to category_path(id: category.id) and return
  		end
  	end
  	# 从商品的title来查找
  	Product.all.each do |product|
  		if product.title.downcase.include? search_value.downcase
  			redirect_to category_path(search_product_id: product.id, id: product.category.id) and return
  		end
  	end

  	render template: 'categories/show'
  end
end
