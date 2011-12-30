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
       
      20.times do
          @treatments << Factory(:treatment, :patient => @patient, 
                                 :notes => "Foo bar")
      end       
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
      mp1 = Factory(:treatment, :patient => @patient, :notes => "Foo bar")
      mp2 = Factory(:treatment, :patient => @patient, :notes => "Baz quux")
      get :index, :patient_id => @patient.id
      response.should have_selector("td", :content => mp1.notes)
      response.should have_selector("td", :content => mp2.notes)
    
    end

    it "should paginate treatments" do
        get :index, :patient_id => @patient.id 
        response.should have_selector("div.pagination")
        
        response.should have_selector("a",:content => "2")
        response.should have_selector("a",:content => "Next")   
        
    end
  end
end

      
  
      
      
      
