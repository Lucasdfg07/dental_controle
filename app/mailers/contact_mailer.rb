class ContactMailer < ActionMailer::Base
  default from: "noreply.dentalcontrole@gmail.com"

  def contact_message(contact)
    @contact = contact
    mail( :to => "lucassiqueirafernandes07@gmail.com", :subject => "Nova Mensagem de contato DentalControle")
  end
end
