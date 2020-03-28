class OfficeVisitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_office_visit, only: [:show, :edit, :update, :destroy]
  before_action :set_patient, only: [:index, :new, :export]

  require './lib/office_visits_pdf'


  def index
    @q = OfficeVisit.ransack(params[:q])
    
    @office_visits = @q.result.where(patient: @patient)
                      .order(date: :ASC, hour: :ASC)
                      .paginate(page: params[:page], per_page: 10)
    

    if params[:page].present? && params[:page] > "1"
      @count = (params[:page].to_i - 1) * 10
    else
      @count = 0
    end
  end

  
  def export
    @office_visits = OfficeVisit.all.order(date: :ASC, hour: :ASC)
    
    pdf = OfficeVisitsPdf::office_visits(@office_visits)
    send_data pdf.render, filename: 'office_visits.pdf', 
    type: 'application/pdf', disposition: 'inline'
  end


  def show
  end


  def new
    @office_visit = OfficeVisit.new

    show_calendar
  end

  def edit
    show_calendar
  end

  def show_calendar
    @patients_per_day = OfficeVisit.joins(:patient).where("patients.user_id = ?", current_user.id).order(hour: :ASC).group_by(&:date)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end


  def create
    @office_visit = OfficeVisit.new(office_visit_params)

    respond_to do |format|
      if @office_visit.save
        if params[:welcome].present?
          format.html { redirect_to patients_path, notice: 'Office visit was successfully created.' }
        else
          format.html { redirect_to root_path, notice: 'Office visit was successfully created.' }
        end
        format.json { render :show, status: :created, location: @office_visit }
      else
        format.html { render :new }
        format.json { render json: @office_visit.errors, status: :unprocessable_entity }
      end
    end

    SendSMS.new(@office_visit).mark
  end


  def update
    respond_to do |format|
      if @office_visit.update(office_visit_params)
        if params[:welcome].present?
          format.html { redirect_to root_path, notice: 'Office visit was successfully updated.' }
        else
          format.html { redirect_to office_visits_path(id: params[:patient]), notice: 'Office visit was successfully updated.' }
        end
        format.json { render :show, status: :ok, location: @office_visit }
      else
        format.html { render :edit }
        format.json { render json: @office_visit.errors, status: :unprocessable_entity }
      end
    end

    if params[:office_visit][:date].present? && params[:office_visit][:hour].present?
      SendSMS.new(@office_visit).remark
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
      params.require(:office_visit).permit(:patient_id, :date, :hour, :status, :payment_method, :treatment, :value, {documents: []})
    end
end
