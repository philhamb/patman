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
          
          @treatment = Factory(:treatment, :patient => @patient, :user => @user)
          second = Factory(:treatment, :patient => @patient, :user => @user, 
          :notes => "blahblay", :tests => "blaylblayblay", :treatment => "bather")
          third = Factory(:treatment, :patient => @patient, :user => @user, 
          :notes  => "blahblay", :tests => "blaylblayblay", :treatment => "bather")
       
          @treatments = [@treatment, second, third ]  
       
      5.times do
          @treatments << Factory(:treatment, :patient => @patient, :user=> @user,
                                 :notes => "etc",
                                 :tests => "etc etc",
                                 :treatment => "Foo bar")
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
            
        mp1 = Factory(:treatment, :patient => @patient, :user=> @user, :notes => "yes", 
                      :tests => "no", :treatment => "More same")
        mp2 = Factory(:treatment, :patient => @patient, :user=> @user, :notes => "yes", 
                      :tests => "no", :treatment => "Baz quux")
        get :index, :patient_id => @patient.id
        response.should have_selector("td", :content => mp1.treatment)
        response.should have_selector("td", :content => mp2.treatment)
      end

      it "should paginate treatments" do
        20.times do
          @treatments << Factory(:treatment, 
                                 :patient => @patient, 
                                 :user => @user,
                                 :notes => "etc",
                                 :tests => "etc etc",
                                 :treatment => "Foo bar")
        end       
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
  
  describe "Get 'show'" do
  
  before(:each) do   
    @treatment = Factory(:treatment, :patient => @patient, :user => @user)
  end
    
    it "should be successful" do
      get :show, :patient_id => @patient.id, :id => @treatment.id
      response.should be_success
    end

    it "should find the right treatment" do 
      get :show, :patient_id => @treatment.patient.id, :id => @treatment.id
      assigns(:treatment).should == @treatment
    end

    it "should have the right title" do
      get :show, :patient_id => @patient.id, :id => @treatment.id
      response.should have_selector("title", :content =>"Treatment")
    end

    it "should include the patients name" do
      get :show, :patient_id => @patient.id, :id => @treatment.id
      response.should have_selector("h3", :content => @patient.full_name)
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

  describe "PUT 'update'" do
    
    before(:each) do
     @treatment = @patient.treatments.create(Factory.attributes_for(:treatment))  
    end

    describe "failure" do
      
      before(:each) do
        @attr = { :notes => "", :tests => "", :treatment => "" }
      end
      
      it "should render the 'edit' page" do
        put :update, :patient_id => @patient.id, :id => @treatment.id, :treatment => @attr
        response.should render_template('edit')
      end
      
      it "should have the right title" do
        put :update, :patient_id => @patient.id, :id => @treatment.id, :treatment => @attr
        response.should have_selector("title", :content => "Edit Treatment")
      end
    end
    
    describe "success" do
      
      before(:each) do
        @attr = { :notes => "More notes", :tests => "New tests", :treatment => "Extra treatment" }
      end
      
      it "should change the patient's attributes" do
        put :update, :patient_id => @patient.id, :id => @treatment.id, :treatment => @attr
        @treatment.reload
        @treatment.notes.should  == @attr[:notes]
        @treatment.tests.should  == @attr[:tests]
        @treatment.treatment.should == @attr[:treatment]       
      end
      
      it "should redirect to the treatment index page" do
        put :update, :patient_id => @patient.id, :id => @treatment.id, :treatment => @attr
        response.should redirect_to(patient_treatments_path(@patient))
      end
      
      it "should have a flash message" do
        put :update, :patient_id => @patient.id, :id => @treatment.id, :treatment => @attr
        flash[:success].should =~ /updated/
      end
    end  
  end  
end

      
  
      
      
      
