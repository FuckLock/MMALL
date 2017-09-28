class AddColumnImageToProductImage < ActiveRecord::Migration[5.0]
  def change
  	add_column :product_images, :image, :string
  end
end
