# == Schema Information
#
# Table name: evaluations
#
#  id              :integer         not null, primary key
#  symptoms        :string(255)
#  onset           :string(255)
#  trauma_history  :string(255)
#  medical_history :string(255)
#  current_health  :string(255)
#  evaluation      :string(255)
#  patient_id      :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class Evaluation < ActiveRecord::Base
  
  attr_accessible :symptoms, :onset, :trauma_history, :medical_history, 
                  :current_health, :evaluation

  belongs_to :patient
  belongs_to :user

  validates :symptoms, :presence => true
  validates :onset, :presence => true
  validates :evaluation, :presence => true
end
