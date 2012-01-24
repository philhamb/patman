class TreatmentsController < ApplicationController

  def index
    @patient = Patient.find(params[:patient_id]) 
   
    if @patient.treatments.empty?
      flash[:notice] = "No treatments exist for this patient"
      redirect_to @patient
    else
      @title = "Treatment Record"
      @number = @patient.treatments.count
      @treatments = @patient.treatments.paginate :per_page => 8,
                   :page => params[:page]
      @last_treatment = @treatments.first.created_at
    end
  end

  def new
  
  @patient = Patient.find(params[:patient_id])
  @treatment = @patient.treatments.new(params[:treatment])
  @title = "New Treatment"
  end
  
  def show
  @patient = Patient.find(params[:patient_id])
  @treatment = @patient.treatments.find(params[:id])
  @title = "Treatment"
  
 
  
  end
  
  def create
  @patient = Patient.find(params[:patient_id])
  @treatment = @patient.treatments.new(params[:treatment])
  @treatment.user_id = current_user.id
  if @treatment.update_attributes(params[:treatment])
       flash[:success] = "New treatment record created!"
      redirect_to @patient
    else
      @title = "New Treatment"
      render 'new'
    end
  end
   
  def edit
   @patient = Patient.find(params[:patient_id])
   @treatment = @patient.treatments.find(params[:id])
   @title = "Edit Treatment" 
  end  
  
  def update
    @patient = Patient.find(params[:patient_id])
    @treatment = @patient.treatments.find(params[:id])
    if @treatment.update_attributes(params[:treatment])
      flash[:success] = "Treatment  updated."
      redirect_to patient_treatments_path(@patient)
    else
      @title = "Edit Treatment"
      render 'edit'
    end
  end
end
