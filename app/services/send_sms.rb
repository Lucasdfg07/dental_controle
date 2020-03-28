require 'dotenv'
Dotenv.load('.env')

class SendSMS
  require 'comtele_sdk'
  include ComteleSdk

  def initialize(office_visit)
    @user = office_visit.patient.user

    @visit = office_visit
  end

  def remark
    @phrase = "Olá, #{@visit.patient.name}, sua consulta odontológica com o Dr. #{@visit.patient.user.name} foi remarcada para a data #{@visit.date}, #{@visit.hour} horas."

    api_key(@visit, @phrase)
  end

  def mark
    @phrase = "Olá, #{@visit.patient.name}, sua consulta odontológica com o Dr. #{@visit.patient.user.name} foi confirmada para a data #{@visit.date}, #{@visit.hour} horas."
    
    api_key(@visit, @phrase)
  end

  def api_key(visit, phrase)
    # catching api_key
    api_key = ENV["API_KEY"]

    messages = @user.messages_sent
    
    if @user.plan == "Básico" && messages <= 250 || 
       @user.plan == "Intermediário" && messages <= 400 ||
       @user.plan == "Avançado" && messages <= 600

        # Send the message
        @API_KEY = "#{api_key}"
        textmessage_service = TextMessageService.new(@API_KEY)
        result = textmessage_service.send('Sender', phrase ,[visit.patient.telephone])

        # Increment User message count
        @user.increment(:messages_sent, 1)
    end
  end

end
