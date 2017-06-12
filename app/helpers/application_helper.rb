# frozen_string_literal: true

module ApplicationHelper
  def show_add_to_cart(product, options = {})
    html_class = 'btn btn-danger add-to-cart-btn'
    html_class += " #{options[:html_class]}" unless options[:html_class].blank?
    link_to "<i class='fa fa-spinner'></i> 加入购物车".html_safe, shopping_carts_path(product_id: product.id), class: html_class, 'data-product-id': product.id
  end
end
