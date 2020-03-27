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

    # Send form email
    @contact = Contact.new

    # Graphs colocar no helper
    if user_signed_in?
      @total = OfficeVisit.joins(:patient).count
      @money = OfficeVisit.joins(:patient).where("payment_method = 0 AND patients.user_id = ?", current_user.id).count
      @card = OfficeVisit.joins(:patient).where("payment_method = 1 AND patients.user_id = ?", current_user.id).count
      @health_insurance = OfficeVisit.joins(:patient).where("payment_method = 2 AND patients.user_id = ?", current_user.id).count
    end
  end

  def send_mail
    if Contact.create(contact_params)
      redirect_to root_path, notice: 'Mensagem enviada com sucesso! Em até 48 horas um email de resposta à sua sugestão ou dúvida será enviado para o seu email!'
    else
      redirect_to root_path, alert: 'Erro no envio do email. Tente novamente mais tarde!'
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :telephone, :message)
  end
end
