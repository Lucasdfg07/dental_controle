class OfficeVisitsController < ApplicationController
  before_action :set_office_visit, only: [:show, :edit, :update, :destroy]
  before_action :set_patient, only: [:index, :new]


  def index
    @office_visits = OfficeVisit.where(patient: @patient)
  end


  def show
  end


  def new
    @office_visit = OfficeVisit.new
  end

  def edit
  end


  def create
    @office_visit = OfficeVisit.new(office_visit_params)

    respond_to do |format|
      if @office_visit.save
        format.html { redirect_to patients_path, notice: 'Office visit was successfully created.' }
        format.json { render :show, status: :created, location: @office_visit }
      else
        format.html { render :new }
        format.json { render json: @office_visit.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @office_visit.update(office_visit_params)
        format.html { redirect_to office_visits_path(id: params[:patient]), notice: 'Office visit was successfully updated.' }
        format.json { render :show, status: :ok, location: @office_visit }
      else
        format.html { render :edit }
        format.json { render json: @office_visit.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @office_visit.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'Office visit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_patient
      @patient = Patient.find(params[:id])
    end

    def set_office_visit
      @office_visit = OfficeVisit.find(params[:id])
    end

    def office_visit_params
      params.require(:office_visit).permit(:patient_id, :date, :hour, :status, :payment_method, :treatment, :value, :upload)
    end
end
