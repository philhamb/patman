class Treatment < ActiveRecord::Base
  attr_accessible :notes, :tests, :treatment, :user_id, :created_at
  
  belongs_to :user
  belongs_to :patient
  
  validates :notes, :presence => true
  validates :patient_id, :presence => true
  
  #default_scope :order => 'treatments.created_at DESC'
  
 
   
end
