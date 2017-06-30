module Admin::CategoriesHelper
  def get_category_id(root_categories, current_category)
    root_categories.each do |category|
      next if category == current_category
      return current_category.ancestry == category.id.to_s ? category.id : ''
    end
  end
end
