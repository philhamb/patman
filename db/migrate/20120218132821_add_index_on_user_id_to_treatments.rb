class AddIndexOnUserIdToTreatments < ActiveRecord::Migration
  def self.up
    add_index :treatments, :user_id
  end

  def self.down
    remove_index :treatments, :user_id
  end
end
