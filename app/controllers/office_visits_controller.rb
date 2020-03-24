class OfficeVisitsController < ApplicationController
  before_action :set_office_visit, only: [:show, :edit, :update, :destroy]

  # GET /office_visits
  # GET /office_visits.json
  def index
    @office_visits = OfficeVisit.all
  end

  # GET /office_visits/1
  # GET /office_visits/1.json
  def show
  end

  # GET /office_visits/new
  def new
    @office_visit = OfficeVisit.new
  end

  # GET /office_visits/1/edit
  def edit
  end

  # POST /office_visits
  # POST /office_visits.json
  def create
    @office_visit = OfficeVisit.new(office_visit_params)

    respond_to do |format|
      if @office_visit.save
        format.html { redirect_to @office_visit, notice: 'Office visit was successfully created.' }
        format.json { render :show, status: :created, location: @office_visit }
      else
        format.html { render :new }
        format.json { render json: @office_visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /office_visits/1
  # PATCH/PUT /office_visits/1.json
  def update
    respond_to do |format|
      if @office_visit.update(office_visit_params)
        format.html { redirect_to @office_visit, notice: 'Office visit was successfully updated.' }
        format.json { render :show, status: :ok, location: @office_visit }
      else
        format.html { render :edit }
        format.json { render json: @office_visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /office_visits/1
  # DELETE /office_visits/1.json
  def destroy
    @office_visit.destroy
    respond_to do |format|
      format.html { redirect_to office_visits_url, notice: 'Office visit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_office_visit
      @office_visit = OfficeVisit.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def office_visit_params
      params.require(:office_visit).permit(:date, :hour, :status, :payment_method, :treatment, :value, :upload)
    end
end
