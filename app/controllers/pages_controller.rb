class PagesController < ApplicationController
  def home
   @title = "Home"
   @patients = Patient.all
  end

  def admin
   @title = "Admin"
  end

  def support
   @title = "Support"
  end

end
