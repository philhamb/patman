class PatientsController < ApplicationController
  def new
    @patient = Patient.new
    @title   = "New Patient"
  end
  
  def show
    @patient = Patient.find(params[:id]) 
    @title = @patient.f_name 
  end
  
  def create
    @patient = Patient.new(params[:patient])
    if @patient.save
       flash[:success] = "New patient record created!"
      redirect_to @patient
    else
      @title = "New Patient"
      render 'new'
    end
  end
end





