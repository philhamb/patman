require 'spec_helper'

describe "Patients" do
  describe "new_p" do
    describe "failure" do
      it "should not make a new user" do
        lambda do
          visit new_p_path
          fill_in "First Name",     :with => ""
          fill_in "Surname",        :with => ""
          fill_in "Email Address",  :with => ""
          click_button
          response.should render_template('patients/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(Patient , :count)
      end
    end
 
    describe "success" do
    
      it "should make a new patient" do
        lambda do
          visit new_p_path
          fill_in "First Name",     :with => "Example"
          fill_in "Surname",        :with => "Patient"
          fill_in "Email Address",  :with => "example@patient.com"
          select "1961"
          select "July"
          select "15"
          choose "patient_gender_male"
          click_button
          response.should have_selector("div.flash.success",
                                        :content => "New patient")
          response.should render_template('patients/show')
        end.should change(Patient , :count).by(1)
      end
    end
  end
end

    
      
