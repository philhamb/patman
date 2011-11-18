
require 'spec_helper'

describe PatientsController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "New Patient")
    end
  end
  describe "POST 'create'" do

    describe "failure" do

      before(:each) do
        @attr = { :f_name => "", :s_name => "", :dob => "",
                  :gender => "" }
      end

      it "should not create a user" do
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
        @attr = { :f_name => "New", :s_name => "User", :email => "user@example.com",
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
