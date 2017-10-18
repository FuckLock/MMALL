class AddSelectedValueToAddresses < ActiveRecord::Migration[5.0]
  def change
  	add_column :addresses, :selected_value, :integer, default: 0
  end
end
