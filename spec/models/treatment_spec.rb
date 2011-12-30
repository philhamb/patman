require 'spec_helper'

describe Treatment do

  before(:each) do
    
    @patient = Factory(:patient)
    @attr = { :notes     => "value for notes",
              :tests     => "value for tests",
              :treatment => "value for treatment" }
  end

  it "should create a new instance given valid attributes" do
    @patient.treatments.create!(@attr)
  end

  describe "patient associations" do

    before(:each) do
      @Treatment = @patient.treatments.create(@attr)
    end

    it "should have a patient attribute" do
      @Treatment.should respond_to(:patient)
    end

    it "should have the right associated patient" do
      @Treatment.patient_id.should == @patient.id
      @Treatment.patient.should == @patient
    end
  end
end


