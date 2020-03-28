class OfficeVisit < ApplicationRecord
	belongs_to :patient
	has_many :parcels, dependent: :destroy

	validates_presence_of :date, :hour

	enum payment_method: [:Dinheiro, :Cartão, :Convênio]

	mount_uploaders :documents, DocumentUploader
end
