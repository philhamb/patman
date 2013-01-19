class AddIndexToEvaluations < ActiveRecord::Migration
  def change
  add_index :evaluations, [ :patient_id, :user_id, :created_at]
  end
end
