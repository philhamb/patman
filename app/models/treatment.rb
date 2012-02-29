# == Schema Information
#
# Table name: treatments
#
#  id         :integer         not null, primary key
#  notes      :text
#  tests      :text
#  treatment  :text
#  patient_id :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Treatment < ActiveRecord::Base
  attr_accessible :notes, :tests, :treatment
  
  belongs_to :user
  belongs_to :patient
  
  validates :notes, :presence => true
  validates :patient_id, :presence => true
  
  
  
 
   
end
