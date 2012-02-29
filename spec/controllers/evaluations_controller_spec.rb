require 'spec_helper'

describe EvaluationsController do
  render_views
  
  before(:each) do
    @user = test_sign_in(Factory(:user))
    @patient = Factory(:patient)
  end
  
  describe "GET 'index'" do
    describe "For patient with treatment records" do
      
      before(:each) do
        @evaluation = Factory(:evaluation, :patient => @patient, :user => @user)
        second = Factory(:evaluation, :patient => @patient, :user => @user,
                         :symptoms => "foobar foobar",
                         :onset => "foobar foobar", 
                         :evaluation => "foobarfoobar")
        third  = Factory(:evaluation, :patient => @patient, :user => @user,
                         :symptoms => "foobar foobar",
                         :onset => "barfoo", 
                         :evaluation => "barfoo")
        @evaluations = [@evaluation, second, third]
      end
      
      it "should be successful" do
        get 'index', :patient_id => @patient.id
        response.should be_success
      end
      
      it "should have the right title" do
      get 'index', :patient_id => @patient.id
      response.should have_selector("title", :content => "Evaluation")
      end
      
      it "should have an element for evaluation" do
         mp1 = Factory(:evaluation, :patient => @patient, :user => @user, 
                       :symptoms => "yes", 
                       :onset => "no", 
                       :evaluation => "Maybe")
        mp2= Factory(:evaluation, :patient => @patient, :user => @user,
                     :symptoms => "Many", 
                     :onset => "recent", 
                     :evaluation => "definite")
        get :index, :patient_id => @patient.id
        response.should have_selector("td", :content => mp1.evaluation)
        response.should have_selector("td", :content => mp2.evaluation)
      end
    end
    
    describe "for patient with no evaluations" do
    
      it "should redirect to patient index" do
        get :index, :patient_id => @patient.id 
        response.should redirect_to @patient
        flash[:notice].should =~ /no evaluation /i
      end
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new', :patient_id => @patient.id 
      response.should be_success
    end 
      
    it "should have the correct title" do
      get 'new', :patient_id => @patient.id
      response.should have_selector("title", :content => "New Evaluation")
    end
  end

end
