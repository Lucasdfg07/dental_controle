class PatientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_patient, only: [:show, :edit, :update, :destroy]


  def index
    @q = Patient.ransack(params[:q])
    @patients = @q.result(distinct: true)
                .where(user: current_user)
                .order(name: :ASC)
                .paginate(page: params[:page], per_page: 10)
    

    if params[:page].present? && params[:page] > "1"
      @count = (params[:page].to_i - 1) * 10
    else
      @count = 0
    end
  end


  def show
  end


  def new
    @patient = Patient.new
  end


  def edit
  end


  def create
    @patient = Patient.new(patient_params)
    @patient.user = current_user

    respond_to do |format|
      if @patient.save
        format.html { redirect_to patients_path, notice: 'Paciente criado com sucesso!' }
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { render :new }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to patients_path, notice: 'Paciente editado com sucesso!' }
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url, notice: 'Paciente apagado com sucesso!' }
      format.json { head :no_content }
    end
  end

  private

    def set_patient
      @patient = Patient.find(params[:id])
    end


    def patient_params
      params.require(:patient).permit(:name, :document, :address, :telephone)
    end
end
