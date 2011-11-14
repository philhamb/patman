class ChangePatientsGender < ActiveRecord::Migration
  def self.up
   change_column :patients, :gender, :string
  end

  def self.down
  end
end
