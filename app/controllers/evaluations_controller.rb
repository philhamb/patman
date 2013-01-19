class EvaluationsController < ApplicationController
before_filter :authenticate
before_filter :admin_user,   :only => :destroy

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
    @patient = Patient.find(params[:patient_id])
    @evaluation = @patient.evaluations.new(params[:evaluation])
    
  end
  
  def create
    @patient = Patient.find(params[:patient_id])
    @evaluation = @patient.evaluations.new(params[:evaluation])
    @evaluation.user_id = current_user.id
    if @evaluation.update_attributes(params[:evaluation])
      flash[:success] = "New evaluation record created!"
      redirect_to @patient
    else
      @title = "New Evaluation"
      render 'new'
    end
  end
  
  def show
    @evaluation = Evaluation.find(params[:id])
    @title = "Evaluation"
  end 
  
  def edit
    
    @title = "Edit Evaluation"
    @evaluation = Evaluation.find(params[:id])
  end
  
  def update
    @evaluation = Evaluation.find(params[:id])
    if @evaluation.update_attributes(params[:evaluation])
      flash[:success] = "Evaluation  updated."
      redirect_to patient_evaluations_path(@evaluation.patient_id)
    else
      @title = "Edit evaluation"
      render 'edit'
    end
  end
  
  def destroy
    Evaluation.find(params[:id]).destroy
    flash[:success] = "Evaluation destroyed "
    redirect_to root_path
  end
  
  private
  
  def authenticate
      deny_access unless signed_in?
  end
  
  def admin_user
      redirect_to(root_path) unless current_user.admin?
  end
end
