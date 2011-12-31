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

  def show
  
  end
end
