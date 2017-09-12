class AddColumn < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :phone_num, :integer
  	add_column :users, :username, :string
  	add_column :users, :question, :string
  	add_column :users, :answer, :string
  end
end
