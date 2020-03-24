class Patient < ApplicationRecord
	belongs_to :user
	has_many :office_visits, dependent: :destroy
	has_many :spents, dependent: :destroy

	validates_presence_of :name, :address, :telephone
end
