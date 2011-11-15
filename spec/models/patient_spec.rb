# == Schema Information
#
# Table name: patients
#
#  id          :integer         not null, primary key
#  f_name      :string(255)
#  s_name      :string(255)
#  dob         :date
#  email       :string(255)
#  mobile_no   :integer
#  landline_no :integer
#  occupation  :string(255)
#  interests   :string(255)
#  gender      :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Patient do


  before(:each) do
    @attr = {
      :f_name => "Example",
      :s_name => "Patient",
      :dob    => "1/2/1989",
      :email  => "patient@example.com",
      :mobile_no => "1234567890",
      :landline_no => "123456789",
      :occupation  => "Manager",
      :interests   => "triathlon",
      :gender      => "male"
   }
 end

  it "should create a new instance given valid attributes" do
    Patient.create!(@attr)
  end

  it "should require a first name" do
    no_first_name_patient = Patient.new(@attr.merge(:f_name => ""))
    no_first_name_patient.should_not be_valid   
  end

  it "should reject first names that are too long" do
    long_first_name = a * 51
    long_first_name_patient = Patient.new(@attr.merge(:f_name => long_first_name))
    long_first_name_patient.should_not be_valid
  end  

  it "should reject surnames that are too long" do
    long_surname = a * 51
    long_surname_patient = Patient.new(@attr.merge(:s_name => long_surname))
    long_surname_patient.should_not be_valid
  end  

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_patient = Patient.new(@attr.merge(:email => address))
      valid_email_patient.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_patient = Patient.new(@attr.merge(:email => address))
      invalid_email_patient.should_not be_valid
    end
  end

  it "should require a date of birth" do
    no_dob_patient = Patient.new(@attr.merge(:dob => ""))
    no_dob_patient.should_not be_valid
  end

 it "should not accept a date of birth in the future" do 
    future_dob = DateTime.now + 1
    future_dob_patient = Patient.new(@attr.merge(:dob => future_dob))
    future_dob_patient.should_not be_valid 
  end 




end


