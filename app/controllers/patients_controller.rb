class PatientsController < ApplicationController
  def new
    @patient = Patient.new
    @title   = "New Patient"
  end
  
  def index
    @title = "All patients"
    @patients = Patient.all
  end
  
  def show
    @patient = Patient.find(params[:id]) 
    @title = @patient.f_name 
    @age = Date.today.year - @patient.dob.year
    @dob = @patient.dob.strftime("%e/%_m/%Y ")
    @start = @patient.created_at.strftime("%e/%_m/%Y ")
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
  
  def edit
    @patient = Patient.find(params[:id])
    @title = "Edit patient"
  end
  
  def update
    @patient = Patient.find(params[:id])
    if @patient.update_attributes(params[:patient])
      flash[:success] = "Profile updated."
      redirect_to @patient
    else
      @title = "Edit patient"
      render 'edit'
    end
  end
end




