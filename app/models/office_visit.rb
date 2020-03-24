class OfficeVisit < ApplicationRecord
	belongs_to :patient
	has_many :parcels, dependent: :destroy

	validates_presence_of :date, :hour, :payment_method, :treatment, :value
end
