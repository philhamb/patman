class PatientsController < ApplicationController
before_filter :authenticate
before_filter :admin_user,   :only => :destroy

  def new
    @patient = Patient.new
    @title   = "New Patient"
  end
  
  def index
    @title = "All patients"
    @search = Patient.search(params[:search])
    @patients = @search.paginate(:page => params[:page], :per_page => 8)
      if @patients.empty?
        flash.now[:notice] = "No patient found"
      end
  end
  
  def show
    @patient = Patient.find(params[:id]) 
    @title = @patient.f_name + " "+ @patient.s_name
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
  
   def destroy
    Patient.find(params[:id]).destroy
    flash[:success] = "Patient destroyed."
    redirect_to patients_path
  end

 private
    
    def authenticate
      deny_access unless signed_in?
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end


