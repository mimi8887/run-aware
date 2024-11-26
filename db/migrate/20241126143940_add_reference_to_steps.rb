class AddReferenceToSteps < ActiveRecord::Migration[7.1]
  def change
    add_reference :steps, :route, null: false, foreign_key: true
  end
end
