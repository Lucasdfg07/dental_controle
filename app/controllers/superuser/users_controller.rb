module Superuser
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: [:show, :edit, :update]


    def index
      # @q = User.ransack(params[:q])
      # @users = @q.result(distinct: true)
      #             .where(user: current_user)
      #             .order(name: :ASC)
      #             .paginate(page: params[:page], per_page: 10)
      

      if params[:page].present? && params[:page] > "1"
        @count = (params[:page].to_i - 1) * 10
      else
        @count = 0
      end

      @users = User.order(payment_expiration: :ASC).paginate(page: params[:page], per_page: 20)
      @count = 0
    end


    def show
    end


    def new
      @user = User.new
    end


    def edit
    end


    def create
      @user = User.new(user_params)

      respond_to do |format|
        if @user.save
          format.html { redirect_to superuser_users_path, notice: 'Usuário criado com sucesso!' }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end


    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to superuser_users_path, notice: 'Usuário editado com sucesso!' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:name, :email, :plan, :payment_status, :payment_expiration)
      end 
  end         
end