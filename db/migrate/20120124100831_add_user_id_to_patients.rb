class AddUserIdToPatients < ActiveRecord::Migration
  def self.up
    add_column :patients, :user_id, :integer
  end

  def self.down
    remove_column :patients, :user_id
  end
end
