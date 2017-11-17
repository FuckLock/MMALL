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
		# 通过ElaticSearch来实现查找功能
		search_category = Category.search(search_value).to_a
		redirect_to category_path(id: search_category.first.id) and return if search_category.any?
		search_product = Product.search(search_value).to_a
		render template: 'categories/show' and return if search_product.empty?
		product_id = search_product.first.id
		category_id = Product.find_by(id: product_id).category.id
		redirect_to category_path(search_product_id: product_id, id: category_id)
  end
end
