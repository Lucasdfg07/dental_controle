class SpentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_spent, only: [:edit, :update, :destroy]


  def index
    @spents = Spent.where(user: current_user).paginate(page: params[:page], per_page: 5)

    if params[:id].present?
      @spent = Spent.find(params[:id])
    else
      @spent = Spent.new
    end

    if params[:page].present? && params[:page] > "1"
      @count = (params[:page].to_i - 1) * 5
    else
      @count = 0
    end
  end

  def edit
    redirect_to spents_path(id: @spent)
  end

 
  def create
    @spent = Spent.new(spent_params)
    @spent.user = current_user

    if @spent.save
      redirect_to request.referrer, notice: 'Spent was successfully created.'
    else
      redirect_to request.referrer, alert: 'Erro na criação do gasto.'
    end
  end


  def update
      if @spent.update(spent_params)
        redirect_to spents_path, notice: 'Spent was successfully updated.'

      else
        redirect_to spents_path, alert: 'Erro na atualização do gasto.'
      end
  end


  def destroy
    @spent.destroy
    respond_to do |format|
      format.html { redirect_to spents_url, notice: 'Spent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_spent
      @spent = Spent.find(params[:id])
    end


    def spent_params
      params.require(:spent).permit(:value, :description)
    end
end
