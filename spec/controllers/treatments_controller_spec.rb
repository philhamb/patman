require 'spec_helper'

describe TreatmentsController do
  render_views

before(:each) do
  @user = test_sign_in(Factory(:user))
  @patient = Factory(:patient)
end
  describe "GET 'index'" do
    
    describe "For patient with treatment records" do

      before(:each) do
          
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
    
    describe "for patient with no treatments" do
    
      
      
      it "should redirect to patient index" do
        get :index, :patient_id => @patient.id 
        response.should redirect_to @patient
        flash[:notice].should =~ /no treatments /i
      end
    end
  end

  describe "Get 'new'" do
    
    it "should be successful" do
        get 'new', :patient_id => @patient.id 
        response.should be_success
    end 
    it "should have the correct title" do
    get 'new', :patient_id => @patient.id
    response.should have_selector("title", :content => "New Treatment")
    end  
  end

  describe "Post 'create'" do
    
     describe "failure" do
        before(:each) do
          @attr = { :notes => "", :tests => "", :treatment => "" }
        end

        it "should not create a new treatment" do
          lambda do
             post :create, :patient_id => @patient.id, :Treatment => @attr
          end.should_not change(Treatment, :count)
        end

        it "should have the right title" do
          post :create,:patient_id => @patient.id, :Treatment => @attr
          response.should have_selector("title", :content => "New Treatment")
        end

        it "should render the 'new' page" do
          post :create, :patient_id => @patient.id, :Treatment => @attr
          response.should render_template('new')
        end
      end

    describe "Success" do
      before(:each) do
          @attr = { :notes => "Notes", :tests => "Tests", :treatment => "treatment" }
        end
      it "should create a patient" do
        lambda do
          post :create, :patient_id => @patient.id, :treatment => @attr
        end.should change( Treatment, :count).by(1)
      end

      it "should redirect to the patient page" do
        post :create, :patient_id => @patient.id, :treatment => @attr
        response.should redirect_to @patient
      end
      
      it "should have a welcome message" do
        post :create, :patient_id => @patient.id, :treatment => @attr
        flash[:success].should =~ /New treatment record created!/i
      end
    end
  end
  
  describe "GET 'edit'" do
     
      before(:each) do
       
        @treatment = @patient.treatments.create(Factory.attributes_for(:treatment))
        
      end

    it "should be successful" do
      get :edit, :patient_id => @patient.id, :id => @treatment.id
      response.should be_success
    end

    it "should have the right title" do
      get :edit,  :patient_id => @patient.id, :id => @treatment.id
      response.should have_selector("title", :content => "Edit Treatment")
    end
    
  end  
  
  
end

      
  
      
      
      
