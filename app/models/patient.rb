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

  #has_many  :users,       :through   => :treatments
  has_many  :treatments,  :dependent => :destroy
  has_many  :evaluations, :dependent => :destroy
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  

  validates  :f_name,      :presence  => true,
                           :length    => { :maximum => 50 }  
  validates  :s_name,      :presence  => true,
                           :length    => { :maximum => 50 }
  
  validates  :email,        :format     => { :with => email_regex },
                           :unless => Proc.new { |a| a.email.blank? }
  validate   :dob_old  
  validate   :dob_future 
  validates  :dob,         :presence  => true
  validates  :mobile_no,   :length    => { :in => 7..19 }, 
                            :unless => Proc.new { |a| a.mobile_no.blank? }
  validates  :landline_no, :length    => { :in => 7..19 }, 
                            :unless => Proc.new { |a| a.landline_no.blank? }
  validates  :gender,      :inclusion => { :in => %w(male female) }
  validates  :occupation,  :length    => { :maximum => 200 }
  validates  :interests,   :length    => { :maximum => 200 }
  
  def full_name
    [f_name, s_name].join(' ')
  end
  
  def dob_future
    errors.add(:dob, "Date of birth cannot be in the future")if !dob.blank? and dob.future?
  end 
  
  def dob_old   
    errors.add(:dob, "Patient cannot be over 150 years old")if !dob.blank? and dob < 150.years.ago.to_date
  end
  
end







