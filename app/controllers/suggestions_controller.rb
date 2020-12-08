class SuggestionsController < ApplicationController
	def index
		@user = User.all
	end
end
