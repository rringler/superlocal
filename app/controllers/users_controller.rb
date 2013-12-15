class UsersController < ApplicationController
	def show
		@user = User.where(params[:id]).first.decorate
	end
end
