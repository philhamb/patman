class AddIndexOnCreatedAtToTreatments < ActiveRecord::Migration
  def self.up
    add_index :treatments, :created_at
  end

  def self.down
    remove_index :treatments, :created_at
  end
end
