class RemoveStepReferenceFromRoutes < ActiveRecord::Migration[7.1]
  def change
    remove_reference :routes, :step, null: false, foreign_key: true
  end
end
