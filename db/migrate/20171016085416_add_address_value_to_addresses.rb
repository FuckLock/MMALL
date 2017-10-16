class AddAddressValueToAddresses < ActiveRecord::Migration[5.0]
  def change
  	add_column :addresses, :address_value, :integer, default: 0
  end
end
