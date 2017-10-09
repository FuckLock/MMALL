class AddColumnSelectValueToShoppingCarts < ActiveRecord::Migration[5.0]
  def change
  	add_column :shopping_carts, :select_value, :integer, default: 1
  end
end
