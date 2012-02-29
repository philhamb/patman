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

require 'spec_helper'

describe Evaluation do
  before(:each) do
    @user    = Factory(:user)
    @patient = Factory(:patient)
    
    @attr = { :symptoms     => "value for symptoms",
              :onset     => "value for onset",
              :trauma_history  => "value for trauma_history",
              :medical_history => "value for medical_history",
              :current_health => "value for current_health",
              :evaluation => "value for evaluation"
              }
  end

  it "should create a new instance given valid attributes" do
    @patient.evaluations.create!(@attr)
  end
  
  it "should require symptoms" do
    no_symptoms_evaluation = @patient.evaluations.create(@attr.merge(:symptoms => ""))
    no_symptoms_evaluation.should_not be_valid   
  end
  
  it "should require an onset" do
    no_onset_evaluation = @patient.evaluations.create(@attr.merge(:onset => ""))
    no_onset_evaluation.should_not be_valid   
  end
  
  it "should require evaluation" do
    no_evaluation_evaluation = @patient.evaluations.create(@attr.merge(:evaluation => ""))
    no_evaluation_evaluation.should_not be_valid   
  end
  
  describe "user evaluation associations" do

    before(:each) do
      @evaluation = @patient.evaluations.create!(@attr)
    end

    it "should have a patient attribute" do
      @evaluation.should respond_to(:patient)
    end

    it "should have the right associated patient" do
      @evaluation.patient_id.should == @patient.id
      @evaluation.patient.should == @patient
    end
  end
  
  describe "user evaluation associations" do

    before(:each) do
      @evaluation = @patient.evaluations.create!(@attr)
    end

    it "should have a user attribute" do
      @evaluation.should respond_to(:user)
    end
  end
end
