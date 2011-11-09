require 'spec_helper'

describe "LayoutLinks" do

  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end

  it "should have a Admin page at '/admin'" do
    get '/admin'
    response.should have_selector('title', :content => "Admin")
  end

  it "should have an Support page at '/support'" do
    get '/support'
    response.should have_selector('title', :content => "Support")
  end
end

