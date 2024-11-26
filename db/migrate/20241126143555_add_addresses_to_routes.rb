class AddAddressesToRoutes < ActiveRecord::Migration[7.1]
  def change
    add_column :routes, :start_address, :string
    add_column :routes, :end_address, :string
  end
end
