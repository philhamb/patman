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
    @treatment = Treatment.find(params[:id])
    @title = "Treatment"
    if @treatment.patient.user.nil? #remove when user field populated
      @name = "None"
    else 
      @name =  @treatment.patient.user.name
    end
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
    @treatment = Treatment.find(params[:id])
    @title = "Edit Treatment" 
  end  
  
  def update
    @treatment = Treatment.find(params[:id])
    if @treatment.update_attributes(params[:treatment])
      flash[:success] = "Treatment  updated."
      redirect_to patient_treatments_path(@treatment.patient_id)
    else
      @title = "Edit Treatment"
      render 'edit'
    end
  end
end
