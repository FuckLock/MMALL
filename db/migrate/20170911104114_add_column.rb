class AddColumn < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :phone_num, :integer
  end
end
