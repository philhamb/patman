
require 'spec_helper'

describe PatientsController do
  render_views
  
  describe "GET 'index'" do

    describe "for non-signed-in users" do
      it "should deny access" do
        get :index
        response.should redirect_to(signin_path)
      end
    end

    describe "for signed-in users" do
      
      before(:each) do
        @user = test_sign_in(Factory(:user))
        @patient = Factory(:patient)
        second = Factory(:patient, :f_name => "Bob",:s_name => "Smith", 
                         :email => "another@example.com", :dob => "1/2/1973",
                         :gender => "male")
        third  = Factory(:patient, :f_name => "Ben",:s_name => "Jones", 
                         :email => "another@example.com", :dob => "1/2/1973",
                         :gender => "male")
        
        @patients = [@patient, second, third]
      end
      
      it "should be successful" do
        get :index
        response.should be_success
      end
      
      it "should have the right title" do
        get :index
        response.should have_selector("title", :content => "All patients")
      end
      
      it "should have an element for each patient" do
        get :index
        @patients.each do |patient|
          response.should have_selector("li", :content => patient.s_name)
        end
      end
    end
  end



  describe "GET 'new'" do
    
    describe "for non-signed-in users" do
      it "should deny access" do
        get :index
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for signed-in users" do
      
      before(:each) do
        @user = test_sign_in(Factory(:user))
      end
    
        it "should be successful" do
        get 'new'
        response.should be_success
      end
    
      it "should have the right title" do
        get 'new'
        response.should have_selector("title", :content => "New Patient")
      end
    end
  end
  
  
  
  describe "POST 'create'" do

    describe "for non-signed-in users" do
      it "should deny access" do
        get :index
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for signed-in users" do
      before(:each) do
        @user = test_sign_in(Factory(:user))
      end

      describe "failure" do
        before(:each) do
          @attr = { :f_name => "", :s_name => "", :dob => "",
                  :gender => "" }
        end

        it "should not create a patient" do
          lambda do
             post :create, :patient => @attr
          end.should_not change(Patient, :count)
        end

        it "should have the right title" do
          post :create, :Patient => @attr
          response.should have_selector("title", :content => "New Patient")
        end

        it "should render the 'new' page" do
          post :create, :patient => @attr
          response.should render_template('new')
        end
      end

      describe "success" do

        before(:each) do
          @attr = { :f_name => "New", :s_name => "User", 
                    :email => "patient@example.com",
                    :dob => "1/2/1989", :mobile_no => 1234567890, 
                    :landline_no => 1234567890, :occupation => "foobar", 
                    :interests => "foobar", :gender => "male" }
        end

        it "should create a patient" do
          lambda do
            post :create, :patient => @attr
          end.should change(Patient, :count).by(1)
        end

        it "should redirect to the patient page" do
          post :create, :patient => @attr
          response.should redirect_to(patient_path(assigns(:patient)))                  
        end
      
        it "should have a welcome message" do
          post :create, :patient => @attr
          flash[:success].should =~ /New patient record created!/i
        end
      end
    end
  end
  
  describe "GET 'edit'" do

    describe "for non-signed-in users" do
        it "should deny access" do
          get :index
          response.should redirect_to(signin_path)
        end
      end
    
    describe "for signed-in users" do
      
      before(:each) do
        @user = test_sign_in(Factory(:user))
      end  
      before(:each) do
        @patient = Factory(:patient)
      end


      it "should be successful" do
        get :edit, :id => @patient
        response.should be_success
      end

      it "should have the right title" do
        get :edit, :id => @patient
        response.should have_selector("title", :content => "Edit patient")
      end
    end
  end

  describe "PUT 'update'" do
    describe "for non-signed-in users" do
      it "should deny access" do
        get :index
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for signed-in users" do
      
      before(:each) do
        @user = test_sign_in(Factory(:user))
      end
    before(:each) do
      @patient = Factory(:patient)
    end

      describe "failure" do

        before(:each) do
          @attr = { :f_name => "", :s_name => "", :email => "",
                    :dob=> "", :gender=>"" }
        end
      
        it "should render the 'edit' page" do
          put :update, :id => @patient, :patient => @attr
          response.should render_template('edit')
        end
      
        it "should have the right title" do
          put :update, :id => @patient, :patient => @attr
          response.should have_selector("title", :content => "Edit patient")
        end
      end
    
      describe "success" do
      
        before(:each) do
          @attr = { :f_name => "Patrick", :s_name => "Humbly",
                    :email => "newname@example.com"}
        end 
      
        it "should change the patient's attributes" do
          put :update, :id => @patient, :patient => @attr
          @patient.reload
          @patient.f_name.should  == @attr[:f_name]
          @patient.s_name.should  == @attr[:s_name]
          @patient.email.should == @attr[:email]
       
        end
      
        it "should redirect to the patient show page" do
          put :update, :id => @patient, :patient => @attr
          response.should redirect_to(patient_path(@patient))
        end
      
        it "should have a flash message" do
          put :update, :id => @patient, :patient => @attr
          flash[:success].should =~ /updated/
        end
      end
    end
  end
end

