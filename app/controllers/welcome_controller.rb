class WelcomeController < ApplicationController

  require './lib/patients_today_pdf'

  def index

    # Send form email
    @contact = Contact.new

    if user_signed_in?
      if current_user.admin?
        redirect_to superuser_welcome_index_path, notice: 'Bem vindo(a) '+current_user.name
      end


      @q = OfficeVisit.ransack(params[:q])
    
      @office_visits = @q.result.joins(:patient)
                        .where("date(date) = ? AND patients.user_id = ?", Date.today, current_user.id)
                        .order(date: :ASC, hour: :ASC)
      

      if params[:page].present? && params[:page] > "1"
        @count = (params[:page].to_i - 1) * 10
      else
        @count = 0
      end
      
      # Graphs colocar no helper
      @total = OfficeVisit.joins(:patient).count
      @money = OfficeVisit.joins(:patient).where("payment_method = 0 AND patients.user_id = ?", current_user.id).count
      @card = OfficeVisit.joins(:patient).where("payment_method = 1 AND patients.user_id = ?", current_user.id).count
      @health_insurance = OfficeVisit.joins(:patient).where("payment_method = 2 AND patients.user_id = ?", current_user.id).count
    end
  end

  def export
    @office_visits = OfficeVisit.joins(:patient)
    .where("date(date) = ? AND patients.user_id = ?", Date.today, current_user.id)
    .order(date: :ASC, hour: :ASC)
    
    pdf = PatientsTodayPdf::office_visits(@office_visits)
    send_data pdf.render, filename: 'patients_today.pdf', 
    type: 'application/pdf', disposition: 'inline'
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
