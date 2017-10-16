class AddAreaToAddresses < ActiveRecord::Migration[5.0]
  def change
  	add_column :addresses, :area, :string, default: '--请选择--'
  end
end
