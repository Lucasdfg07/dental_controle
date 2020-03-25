class WelcomeController < ApplicationController
  def index
  	@q = OfficeVisit.ransack(params[:q])
    
    @office_visits = @q.result.where(date: Date.today)
                      .order(date: :ASC, hour: :ASC)
                      .paginate(page: params[:page], per_page: 10)
    

    if params[:page].present? && params[:page] > "1"
      @count = (params[:page].to_i - 1) * 10
    else
      @count = 0
    end
  end
end
