class AddUserIdEvaluations < ActiveRecord::Migration
  def self.up
    add_column :evaluations, :user_id, :integer
  end

  def self.down
    remove_column :evaluations, :user_id
  end
end
