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
  
  
  
 
  scope :today, lambda { where("created_at > ? AND  created_at < ?", 
                        Time.now.at_beginning_of_day, Time.now) }
  scope :yesterday, lambda { where("created_at > ? AND  created_at < ?", 
                        Time.now.yesterday.at_beginning_of_day, Time.now.yesterday.end_of_day) }                        
  scope :this_week, lambda { where("created_at > ? AND  created_at < ?",
                       Time.zone.now.at_beginning_of_week,  Time.zone.now) }
                       
  scope :this_month, lambda { where("created_at > ? AND  created_at < ?",
                       Time.zone.now.at_beginning_of_month,  Time.zone.now) }                       
 
   
end
