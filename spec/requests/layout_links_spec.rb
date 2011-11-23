require 'spec_helper'

describe "LayoutLinks" do

  
    
   

  describe "when not signed in" do
    it "should have a signin link" do
      visit root_path
      response.should have_selector("a", :href => signin_path,
                                         :content => "Sign in")
    end
  end

  describe "when signed in" do
    
    before(:each) do
      @user = Factory(:user)
      visit signin_path
      fill_in :email,    :with => @user.email
      fill_in :password, :with => @user.password
      click_button
    end
    
    it "should have a Patients page at '/'" do
      get '/'
      response.should have_selector('title', :content => "All patients")
    end

    it "should have a page at '/users'" do
      get '/users'
      response.should have_selector('title', :content => "All users")
    end
 
    it "should have a page at '/new_p'" do
      get '/new_p'
      response.should have_selector('title', :content => "New Patient")
    end
    
    it "should have a signout link" do
      visit root_path
      response.should have_selector("a", :href => signout_path,
                                         :content => "Sign out")
    end
    
    it "should have a users link" do
      visit root_path
      response.should have_selector("a", :href => users_path,
                                         :content => "Users")
    end                                       
    it "should have a new patient link" do
      visit root_path
      response.should have_selector("a", :href => new_patient_path,
                                      :content => "New patient")
    end
  end
end


