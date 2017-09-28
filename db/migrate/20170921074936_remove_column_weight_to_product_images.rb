class RemoveColumnWeightToProductImages < ActiveRecord::Migration[5.0]
  def change
  	remove_column :product_images, :weight
  end
end
