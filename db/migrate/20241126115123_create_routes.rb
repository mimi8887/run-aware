class CreateRoutes < ActiveRecord::Migration[7.1]
  def change
    create_table :routes do |t|
      t.string :name
      t.string :description
      t.float :distance
      t.float :starting_longitude
      t.float :starting_latitude
      t.float :ending_longitude
      t.float :ending_latitude
      t.string :address
      t.references :step, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
