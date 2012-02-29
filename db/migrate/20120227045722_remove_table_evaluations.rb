class RemoveTableEvaluations < ActiveRecord::Migration
  def self.up
    drop_table :evaluations
  end

  def self.down
  end
end
