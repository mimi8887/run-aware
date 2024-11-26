class CreateSteps < ActiveRecord::Migration[7.1]
  def change
    create_table :steps do |t|
      t.float :longitude
      t.float :latitude
      t.integer :position

      t.timestamps
    end
  end
end
