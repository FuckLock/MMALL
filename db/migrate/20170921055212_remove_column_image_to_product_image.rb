class RemoveColumnImageToProductImage < ActiveRecord::Migration[5.0]
  def change
  	remove_column :product_images, :image_file_name
  	remove_column :product_images, :image_content_type
  	remove_column :product_images, :image_file_size
  	remove_column :product_images, :image_updated_at
  end
end
