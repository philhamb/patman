class PagesController < ApplicationController
  def home
   @title = "Home"
  end

  def admin
   @title = "Admin"
  end

  def support
   @title = "Support"
  end

end
