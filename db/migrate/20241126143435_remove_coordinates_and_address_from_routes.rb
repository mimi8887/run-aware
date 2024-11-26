class RemoveCoordinatesAndAddressFromRoutes < ActiveRecord::Migration[7.1]
  def change
    remove_column :routes, :starting_longitude, :float
    remove_column :routes, :starting_latitude, :float
    remove_column :routes, :ending_longitude, :float
    remove_column :routes, :ending_latitude, :float
    remove_column :routes, :address, :string
  end
end
