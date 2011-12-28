require 'spec_helper'

describe TreatmentsController do
  render_views

  describe "GET 'index'" do
    before(:each) do
        @user = test_sign_in(Factory(:user))
        @patient = Factory(:patient)
    end
   
   it "should be successful" do
       get :index, :patient_id => @patient.id 
       response.should be_success
     end
      
     it "should have the right title" do
       get :index, :patient_id => @patient.id
       response.should have_selector("title", :content => "Treatment Record")
     end
      
    
  end
end


      
      
      
      
