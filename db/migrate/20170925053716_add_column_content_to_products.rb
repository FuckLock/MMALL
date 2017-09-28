class AddColumnContentToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :content, :text
  end
end
