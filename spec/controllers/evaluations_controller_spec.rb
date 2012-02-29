require 'spec_helper'

describe EvaluationsController do
  render_views
  
  before(:each) do
    @user = test_sign_in(Factory(:user))
    @patient = Factory(:patient)
  end
  
  describe "GET 'index'" do
    describe "For patient with evaluation records" do
      
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
  
  describe "Post 'create'" do
    
   describe "failure" do
      before(:each) do
        @attr = { :patient => @patient, :user => @user,
                  :symptoms => "",
                  :evaluation => ""}
      end

      it "should not create a new evaluation" do
        lambda do
           post :create, :patient_id => @patient.id, :Evaluation => @attr
        end.should_not change(Evaluation, :count)
      end

      it "should have the right title" do
        post :create,:patient_id => @patient.id, :evaluation => @attr
        response.should have_selector("title", :content => "New Evaluation")
      end

      it "should render the 'new' page" do
        post :create, :patient_id => @patient.id, :evaluation => @attr
        response.should render_template('new')
      end
    end
    
    describe "Success" do
      before(:each) do
          @attr = { :patient => @patient, :user => @user, 
                       :symptoms => "yes", 
                       :onset => "no", 
                       :evaluation => "Maybe" }
        end
      it "should create an evaluation" do
        lambda do
          post :create, :patient_id => @patient.id, :evaluation => @attr
        end.should change( Evaluation, :count).by(1)
      end

      it "should redirect to the patient page" do
        post :create, :patient_id => @patient.id, :evaluation => @attr
        response.should redirect_to @patient
      end
      
      it "should have a welcome message" do
        post :create, :patient_id => @patient.id, :evaluation => @attr
        flash[:success].should =~ /New evaluation record created!/i
      end
    end
  end
  
end
