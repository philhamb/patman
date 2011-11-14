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
end

