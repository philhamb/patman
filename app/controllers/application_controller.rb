class ApplicationController < ActionController::Base
  helper Xebec::NavBarHelper 
  protect_from_forgery
  include SessionsHelper
end
