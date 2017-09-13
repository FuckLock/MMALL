class AddColumn < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :phone_num, :string
  	add_column :users, :email, :string
  	add_column :users, :question, :string
  	add_column :users, :answer, :string
  end
end
