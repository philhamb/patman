class CreatePatients < ActiveRecord::Migration
  def self.up
    create_table :patients do |t|
      t.string :f_name
      t.string :s_name
      t.date :dob
      t.string :email
      t.integer :mobile_no
      t.integer :landline_no
      t.string :email
      t.string :occupation
      t.string :interests
      t.boolean :gender

      t.timestamps
    end
    add_index :patients, [:f_name, :s_name]
  end

  def self.down
    drop_table :patients
  end
end
