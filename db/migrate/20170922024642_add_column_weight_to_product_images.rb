class AddColumnWeightToProductImages < ActiveRecord::Migration[5.0]
  def change
  	add_column :product_images, :weight, :integer, default: 0
  end
end
