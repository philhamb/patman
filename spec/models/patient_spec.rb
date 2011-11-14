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
      :content => "value for content",
      :user_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Micropost.create!(@attr)
  end
end

