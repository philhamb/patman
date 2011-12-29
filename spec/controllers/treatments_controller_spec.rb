require 'spec_helper'

describe TreatmentsController do
  render_views

  describe "GET 'index'" do
    
    before(:each) do
        @user = test_sign_in(Factory(:user))
        @patient = Factory(:patient)
        @treatment = Factory(:treatment)
        second = Factory(:treatment, :notes => "blahblay", 
                          :tests => "blaylblayblay", 
                          :treatment => "bather")
       third = Factory(:treatment, :notes  => "blahblay", 
                          :tests => "blaylblayblay", 
                          :treatment => "bather")
       
       @treatments = [@treatment, second, third ]        
    end
    it "should be successful" do
       get :index, :patient_id => @patient.id 
       response.should be_success
    end
      
    it "should have the right title" do
       get :index, :patient_id => @patient.id
       response.should have_selector("title", :content => "Treatment Record")
    end
    
    it "should have an element for each treatment" do
      get :index, :patient_id => @patient.id
       @treatments.each do |treatment|
          response.should have_selector("li", :content => treatment.notes)
      end
    end
  end
end


      
      
      
      
