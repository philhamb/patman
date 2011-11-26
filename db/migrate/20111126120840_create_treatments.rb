class CreateTreatments < ActiveRecord::Migration
  def self.up
    create_table :treatments do |t|
      t.text :notes
      t.text :tests
      t.text :treatment
      t.integer :patient_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :treatments
  end
end
