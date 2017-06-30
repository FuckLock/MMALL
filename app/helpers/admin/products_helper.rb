module Admin::ProductsHelper
  def get_children_category(root_categories, product)
    root_categories.each do |category|
      category.children.each do |sub_category|
        return category.children, product.category_id == sub_category.id ? sub_category.id : ''
      end
    end
  end

  def get_product_status(product)
    [Product::Status::ON, Product::Status::OFF].each do |row|
      status = product.status
      return status if status == row
    end
  end
end
