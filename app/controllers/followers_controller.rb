class FollowersController < ApplicationController
	before_filter :authenticate_user!

	def follow
		@followable = params[:klass].constantize.find(params[:id])

		if current_user.following?(@followable)
			current_user.stop_following(@followable)
		else
			current_user.follow(@followable)
		end
		
		respond_to do |format|
			format.js
		end
	end
end
