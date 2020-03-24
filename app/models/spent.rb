class Spent < ApplicationRecord
	belongs_to :patient

	validates_presence_of :value, :description
end
