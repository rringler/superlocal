class VotesController < ApplicationController
	before_filter :authenticate_user!

	def vote
		if params[:direction] == 'up'
		  if current_user.voted_for?(voteable)
		  	current_user.unvote_for(voteable)
		  else
				current_user.vote_exclusively_for(voteable)
			end
		elsif params[:direction] == 'down'
			if current_user.voted_against?(voteable)
				current_user.unvote_for(voteable)
			else
				current_user.vote_exclusively_against(voteable)
			end
		end

		respond_to do |format|
			format.js do
				redirect_to :votable
			end
		end
	end


	private

	def voteable
		params[:klass].constantize.find(params[:id])
	end
end
