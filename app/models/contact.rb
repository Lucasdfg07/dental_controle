class Contact < ApplicationRecord
	validates_presence_of :name, :email, :message

	after_create :send_mailer


	private

	def send_mailer
		ContactMailer.contact_message(self).deliver_now
	end
end
