require 'spec_helper'

describe TreatmentsController do
  render_views

  describe "GET 'index'" do
    
   it "should be successful" do
       get :index
       response.should be_success
     end
      
     it "should have the right title" do
       get :index
       response.should have_selector("title", :content => "Treatment Record")
     end
      
    
  end
end


      
      
      
      
