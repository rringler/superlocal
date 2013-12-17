class VotesController < ApplicationController
	before_filter :authenticate_user!

	def vote
		@voteable = params[:type].downcase
														 .gsub(/decorator/, "")
														 .capitalize
														 .constantize
														 .where(id: params[:id])
														 .first

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
