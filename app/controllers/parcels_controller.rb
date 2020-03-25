class ParcelsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_parcel, only: [:show, :edit, :update, :destroy]
  before_action :set_office_visit, only: [:index, :create]


  def index
    @parcels = Parcel.where(office_visit: @office_visit).paginate(page: params[:page], per_page: 5)

    if params[:id].present?
      @parcel = Parcel.find(params[:id])
    else
      @parcel = Parcel.new
    end

    if params[:page].present? && params[:page] > "1"
      @count = (params[:page].to_i - 1) * 5
    else
      @count = 0
    end
  end

  def edit
    redirect_to parcels_path(id: @office_visit)
  end

  def create
    @parcel = Parcel.new(parcel_params)
    @parcel.office_visit = @office_visit

      if @parcel.save
        redirect_to request.referrer, notice: 'Parcel was successfully created.'
      else
        redirect_to request.referrer, notice: 'Erro ao salvar parcela.'
      end
  end


  def update
    respond_to do |format|
      if @parcel.update(parcel_params)
        format.html { redirect_to @parcel, notice: 'Parcel was successfully updated.' }
        format.json { render :show, status: :ok, location: @parcel }
      else
        format.html { render :edit }
        format.json { render json: @parcel.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @parcel.destroy
    respond_to do |format|
      format.html { redirect_to parcels_url, notice: 'Parcel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_office_visit
      @office_visit = OfficeVisit.find(params[:office])
    end

    def set_parcel
      @parcel = Parcel.find(params[:id])
    end


    def parcel_params
      params.fetch(:parcel, {})
    end
end
