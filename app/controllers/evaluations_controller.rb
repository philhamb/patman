class EvaluationsController < ApplicationController

  def index
    
    @patient = Patient.find(params[:patient_id]) 
   
    if @patient.evaluations.empty?
      flash[:notice] = "No evaluation exists for this patient"
      redirect_to @patient
    else
      @title = "Evaluation Record"
      @search = @patient.evaluations.includes(:user).search(params[:search])
      @evaluations = @search.relation.paginate :per_page =>  10,
                   :page => params[:page]
    end
  end
  
  def new
    @title = "New Evaluation"
  end
  
  def show
  end 
end
