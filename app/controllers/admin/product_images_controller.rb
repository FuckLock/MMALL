module Admin
  class ProductImagesController < Admin::ApplicationController
    before_action :find_product

    def index
      @product_images = @product.product_images
    end

    def create
      params[:images].each do |image|
        @product.product_images << ProductImage.new(image: image)
      end

      redirect_to :back
    end

    def destroy
      @product_image = @product.product_images.find(params[:id])
      flash[:notice] = if @product_image.destroy
                         '删除成功'
                       else
                         '删除失败'
                       end

      redirect_to :back
    end

    def update
      @product_image = @product.product_images.find(params[:id])
      @product_image.weight = params[:weight]
      flash[:notice] = if @product_image.save
                         '修改成功'
                       else
                         '修改失败'
                       end

      redirect_to :back
    end

    private

    def find_product
      @product = Product.find(params[:product_id])
    end
  end
end
