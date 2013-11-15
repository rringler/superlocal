class VotesController < ApplicationController
	before_filter :authenticate_user!

	def vote
		@voteable = params[:klass].constantize.find(params[:id])

		if params[:direction] == 'up'
		  current_user.up_vote(@voteable)
		elsif params[:direction] == 'down'
			current_user.down_vote(@voteable)
		end

		respond_to do |format|
			format.js
		end
	end
end
