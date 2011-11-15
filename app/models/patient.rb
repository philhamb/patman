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

class Patient < ActiveRecord::Base
  
  attr_accessible :f_name, :s_name, :dob, :email,
                  :mobile_no, :landline_no, :occupation,
                  :interests, :gender 
end
