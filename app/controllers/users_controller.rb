class UsersController < ApplicationController
	def show
		@user = User.where(params[:id]).first
		@posts = @user.posts.recent
		@comments = @user.comments.recent
		@following_boards = @user.following_boards
	end
end
