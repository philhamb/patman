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
  it "should have a page at '/signup'" do
    get '/signup'
    response.should have_selector('title', :content => "Sign up")
  end
 
   it "should have the right links on the layout" do
    visit root_path
    click_link "Admin"
    response.should have_selector('title', :content => "Admin")
    click_link "Support"
    response.should have_selector('title', :content => "Support")
    click_link "Home"
    response.should have_selector('title', :content => "Home")
    click_link "Sign up now!"
    response.should have_selector('title', :content => "Sign up")
  end
end


