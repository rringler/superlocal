class VotesController < ApplicationController
	before_filter :authenticate_user!
	
	def new
		@vote = Vote.new
	end

	def create
	end

	def edit
	end

	def update
	end

	def destroy
	end
end
