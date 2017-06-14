module Admin
  class CategoriesController < Admin::BaseController
    def index
      @categories = params[:id].blank? ? Category.roots : Category.find(params[:id]).children
      @categories = @categories.page(params[:page] || 1).per_page(params[:per_page] || 10).order('id desc')
    end

    def new
      @root_categories = Category.roots.order(id: 'desc')
      @category = Category.new
    end

    def create
      @root_categories = Category.roots.order(id: 'desc')
      @category = Category.new(params.require(:category).permit!)

      if @category.save
        flash[:notice] = '保存成功'
        redirect_to admin_categories_path
      else
        render action: :new
      end
    end

    def edit
      @root_categories = Category.roots.order(id: 'desc')
      @category = Category.find(params[:id])
      render action: :new
    end

    def update
      @root_categories = Category.roots.order(id: 'desc')
      @category = Category.find(params[:id])
      @category.attributes = params.require(:category).permit!

      if @category.save
        flash[:notice] = '修改分类成功'
        redirect_to admin_categories_path
      else
        flash[:notice] = '修改分类失败'
        render action: :new
      end
    end

    def destroy
      @category = Category.find(params[:id])
      if @category.destroy
        flash[:notice] = '删除成功'
        redirect_to admin_categories_path
      else
        flash[:notice] = '删除失败'
        redirect_to :back
      end
    end
  end
end
