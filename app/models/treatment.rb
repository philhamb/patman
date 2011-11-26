class Treatment < ActiveRecord::Base
  attr_accessible :notes, :tests, :treatment
  belongs_to :patient
  default_scope :order => 'treatments.created_at DESC'
end
