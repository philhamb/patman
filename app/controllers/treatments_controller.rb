class TreatmentsController < ApplicationController

  def index
    @title = "Treatment Record"
    @patient = Patient.find(params[:patient_id]) 
    @treatments = @patient.treatments.paginate :per_page => 10,
                   :page => params[:page]
    @last_treatment = @treatments.first.created_at
    
  end

  def show
  
  end
end
