class CreateEvaluations < ActiveRecord::Migration
  def self.up
    create_table :evaluations do |t|
      t.string :symptoms
      t.string :onset
      t.string :trauma_history
      t.string :medical_history
      t.string :current_health
      t.string :evaluation
      t.integer :patient_id

      t.timestamps
    end
  end

  def self.down
    drop_table :evaluations
  end
end
