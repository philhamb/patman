class PatientsController < ApplicationController
  def new
    @patient = Patient.new
    @title   = "New Patient"
  end

end
