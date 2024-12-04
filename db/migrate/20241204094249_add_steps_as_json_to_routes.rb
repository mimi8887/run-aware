class AddStepsAsJsonToRoutes < ActiveRecord::Migration[7.1]
  def change
    add_column :routes, :steps_as_json, :string
  end
end
