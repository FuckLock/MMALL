module Admin
  class ProductsController < Admin::ApplicationController
    before_action :find_product, only: %i[edit update destroy]

    def index
      @products = Product.page(params[:page] || 1).per_page(params[:per_page] || 10)
                         .order('id desc')
    end

    def new
      @product = Product.new
      @product_image = @product.product_images.build
      @root_categories = Category.roots
    end

    def ajax_new
      @children_categories = Category.children_of(params["ancestryId"])
      render json: @children_categories, layout: false
    end

    def create
      @product = Product.new(product_attrs)
      @root_categories = Category.roots
      if @product.save
        params[:product_images][:image].each do |image|
          @product.product_images.create!(image: image)
        end
        flash[:notice] = '创建商品成功'
        redirect_to admin_products_path
      else
        flash[:notice] = '创建商品失败'
        render action: :new
      end
    end

    def edit
      @product_images = @product.product_images
      @current_category_id = @product.category_id
      @current_category = Category.find_by(id: @current_category_id)
      if @current_category.has_parent?
        # debugger
        @current_parent_id = @current_category.parent.id
        @siblings_categories = Category.siblings_of(@current_category_id)
      else 
        @current_parent_id = @current_category.id
      end
      @root_categories = Category.roots
      render action: :new
    end

    def update
      @product.attributes = product_attrs
      @root_categories = Category.roots
      if @product.save
        if params[:product_images].present?
          @product.product_images.collect{|image|  image.destroy }
          params[:product_images][:image].each do |image|
            @product.product_images.create!(image: image)
          end
        end
        flash[:notice] = '商品更新成功'
        redirect_to admin_products_path
      else
        flash[:notice] = '商品更新失败'
        render action: :new
      end
    end

    def destroy
      if @product.destroy
        flash[:notice] = '删除成功'
        redirect_to admin_products_path
      else
        flash[:notice] = '删除失败'
        redirect_to :back
      end
    end

    private

    def find_product
      @product = Product.find(params[:id])
    end

    def product_attrs
      params.require(:product).permit(:category_id, :title, :status, :amount, :uuid, :msrp,
                                      :price, :description, :content)
      
    end
  end
end
