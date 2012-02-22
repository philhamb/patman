class RemoveUserIdFromPatients < ActiveRecord::Migration
  def self.up
    remove_column :patients, :user_id
  end

  def self.down
    add_column :patients, :user_id, :integer
  end
end
