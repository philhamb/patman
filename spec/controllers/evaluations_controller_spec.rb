require 'spec_helper'

describe EvaluationsController do
  render_views
  
  before(:each) do
    
    @patient = Factory(:patient)
  end
  
  describe "GET 'index'" do
  
  before(:each) do
    @user = test_sign_in(Factory(:user))
  end
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
  
  before(:each) do
    @user = test_sign_in(Factory(:user))
  end
  
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
  
  before(:each) do
    @user = test_sign_in(Factory(:user))
  end
    
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
  
  describe "Get 'show'" do
  
  before(:each) do  
    @user = test_sign_in(Factory(:user))
    @evaluation = Factory(:evaluation, :patient => @patient, :user => @user)
  end
    
    it "should be successful" do
      get :show, :patient_id => @patient.id, :id => @evaluation.id
      response.should be_success
    end

    it "should find the right evaluation" do 
      get :show, :patient_id => @evaluation.patient.id, :id => @evaluation.id
      assigns(:evaluation).should == @evaluation
    end

    it "should have the right title" do
      get :show, :patient_id => @patient.id, :id => @evaluation.id
      response.should have_selector("title", :content =>"Evaluation")
    end

    it "should include the patients name" do
      get :show, :patient_id => @patient.id, :id => @evaluation.id
      response.should have_selector("h3", :content => @patient.full_name)
    end
  end
  
  describe "GET 'edit'" do
     
    before(:each) do
      @user = test_sign_in(Factory(:user))      
      @evaluation = @patient.evaluations.create(Factory.attributes_for(:evaluation))
    end

    it "should be successful" do
      get :edit, :patient_id => @patient.id, :id => @evaluation.id
      response.should be_success
    end

    it "should have the right title" do
      get :edit,  :patient_id => @patient.id, :id => @evaluation.id
      response.should have_selector("title", :content => "Edit Evaluation")
    end   
  end 
  
  describe "PUT 'update'" do
    
    before(:each) do 
      @user = test_sign_in(Factory(:user))
      @evaluation = @patient.evaluations.create(Factory.attributes_for(:evaluation))  
    end

    describe "failure" do
      
      before(:each) do
        @attr = { :notes => "", :tests => "", :evaluation => "" }
      end
      
      it "should render the 'edit' page" do
        put :update, :patient_id => @patient.id, :id => @evaluation.id, :evaluation => @attr
        response.should render_template('edit')
      end
      
      it "should have the right title" do
        put :update, :patient_id => @patient.id, 
                     :id => @evaluation.id, 
                     :evaluation => @attr
        response.should have_selector("title", :content => "Edit evaluation")
      end
    end
    
    describe "success" do
      
      before(:each) do
        @attr = { :symptoms => "More symptoms", 
                  :onset => "last week", 
                  :evaluation => "Extra evaluation" }
      end
      
      it "should change the patient's attributes" do
        put :update, :patient_id => @patient.id, 
                     :id => @evaluation.id, 
                     :evaluation => @attr
        @evaluation.reload
        @evaluation.symptoms.should  == @attr[:symptoms]
        @evaluation.onset.should  == @attr[:onset]
        @evaluation.evaluation.should == @attr[:evaluation]       
      end
      
      it "should redirect to the evaluation index page" do
        put :update, :patient_id => @patient.id, :id => @evaluation.id, :evaluation => @attr
        response.should redirect_to(patient_evaluations_path(@patient))
      end
      
      it "should have a flash message" do
        put :update, :patient_id => @patient.id, :id => @evaluation.id, :evaluation => @attr
        flash[:success].should =~ /updated/
      end
    end  
  end 
  
  describe "DELETE 'destroy'" do
    
    before(:each) do
     @evaluation = Factory(:evaluation, :patient => @patient, :user => @user)
    end
    
    describe "as non admin user" do
    before(:each) do
      @user = test_sign_in(Factory(:user))
    end
      it "should protect the page" do
        lambda do
          delete :destroy, :id => @evaluation
          response.should redirect_to(root_path)
        end.should change(Evaluation, :count).by(0)
      end
    end
   
    
    describe "as an admin user" do
    before(:each) do
      @user = test_sign_in(Factory(:user, :admin => true))
    end
     it "should destroy the evaluation" do
        lambda do
          delete :destroy, :id => @evaluation
        end.should change(Evaluation, :count).by(-1)
      end
      
      it "should redirect to the patients page" do
        delete :destroy, :id => @evaluation
        response.should redirect_to(root_path)
      end
    end
  end  
  
end
