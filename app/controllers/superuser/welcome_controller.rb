module Superuser
	class WelcomeController < ApplicationController
		def index
			@users = User.all
			@count = 0
		end
	end
end