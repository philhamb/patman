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
#  created_at      :datetime
#  updated_at      :datetime
#

require 'spec_helper'

describe Evaluation do
  before(:each) do
    
    @patient = Factory(:patient)
    patient_id = @patient.id
    @attr = { :symptoms     => "value for symptoms",
              :onset     => "value for onset",
              :trauma_history  => "value for trauma_history",
              :medical_history => "value for medical_history",
              :current_health => "value for current_health",
              :evaluation => "value for evaluation", 
              :patient_id => patient_id}
  end

  it "should create a new instance given valid attributes" do
    Evaluation.new(@attr)
  end
end
