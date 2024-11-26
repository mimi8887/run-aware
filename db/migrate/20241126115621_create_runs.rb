class CreateRuns < ActiveRecord::Migration[7.1]
  def change
    create_table :runs do |t|
      t.time :starting_time
      t.time :ending_time
      t.string :weather
      t.string :tips
      t.string :description
      t.references :user, null: false, foreign_key: true
      t.references :route, null: false, foreign_key: true

      t.timestamps
    end
  end
end
