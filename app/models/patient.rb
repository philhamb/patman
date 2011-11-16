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
#  interests     :string(255)
#  gender      :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Patient < ActiveRecord::Base
    
  attr_accessible :f_name, :s_name, :dob, :email,
                  :mobile_no, :landline_no, :occupation,
                  :interests, :gender 

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates  :f_name,  :presence  => true,
                       :length    => { :maximum => 50}  
  validates  :s_name,  :presence  => true,
                       :length    => { :maximum => 50}
  validates  :email,   :format    => { :with    => email_regex}    
   
 validate   :dob_future
 validates  :dob,     :presence  => true

  def dob_future
    errors.add(:dob, "Date of birth cannot be in the future") if !dob.blank? and dob.future?
  end 
 
end

