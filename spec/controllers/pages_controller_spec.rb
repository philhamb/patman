require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    @base_title = "Patman"
  end

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    it "should have the right title" do
      get 'home'
      response.should have_selector("title", 
                                    :content => @base_title + " | Home")
    end
  end

  describe "GET 'admin'" do
    it "should be successful" do
      get 'admin'
      response.should be_success
    end
      it "should have the right title" do
      get 'admin'
      response.should have_selector("title", 
                                    :content => @base_title + " | Admin")
    end
  end

  describe "GET 'support'" do
    it "should be successful" do
      get 'support'
      response.should be_success
    end
    it "should have the right title" do
      get 'support'
      response.should have_selector("title", 
                                    :content => @base_title + " | Support")
    end
  end

end
