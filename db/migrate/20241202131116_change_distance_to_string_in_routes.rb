class ChangeDistanceToStringInRoutes < ActiveRecord::Migration[6.0]  # version number may vary
  def change
    change_column :routes, :distance, :string
  end
end
