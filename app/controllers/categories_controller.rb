class CategoriesController < ApplicationController
	layout 'home'

	before_action :find_category, only: [:show, :down_product, :up_product]
  def show
    # 如果是post说明是ajax请求
  	render partial: "categories/product",layout: false if request.method == "POST"    
  end

  def down_product
  	@products = @products.sort{|a,b| a.price <=> b.price}
  	render partial: "categories/product",layout: false
  end

  def up_product
  	@products = @products.sort{|a,b| b.price <=> a.price}
  	render partial: "categories/product",layout: false
  end

  private
  def find_category
    @category = Category.find(params[:id])
    if params[:search_product_id].present?
      @products = Product.where(id: params[:search_product_id])
    else
  	  @products = @category.products.onshelf.page(params[:page] || 1).per_page(params[:per_page] || 12)
                         .order('id desc').includes(:main_product_image)
    end
  end
end
