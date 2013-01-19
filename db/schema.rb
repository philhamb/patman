# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130119093846) do

  create_table "evaluations", :force => true do |t|
    t.string   "symptoms"
    t.string   "onset"
    t.string   "trauma_history"
    t.string   "medical_history"
    t.string   "current_health"
    t.string   "evaluation"
    t.integer  "patient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "evaluations", ["patient_id", "user_id", "created_at"], :name => "index_evaluations_on_patient_id_and_user_id_and_created_at"

  create_table "patients", :force => true do |t|
    t.string   "f_name"
    t.string   "s_name"
    t.date     "dob"
    t.string   "email"
    t.string   "mobile_no",   :limit => 20
    t.string   "landline_no", :limit => 20
    t.string   "occupation"
    t.string   "interests"
    t.string   "gender"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "treatments", :force => true do |t|
    t.text     "notes"
    t.text     "tests"
    t.text     "treatment"
    t.integer  "patient_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "treatments", ["patient_id", "user_id", "created_at"], :name => "index_treatments_on_patient_id_and_user_id_and_created_at"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
