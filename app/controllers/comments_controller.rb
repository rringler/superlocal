class CommentsController < ApplicationController
	def new
		@comment = Comment.new
	end

	def create
		@post = Post.where(id: params[:post_id])
		@user = User.where(id: params[:user_id])
		@comment = Comment.build_from(@post, @user, params[:text])
	end

	def show
	end

	def edit
	end

	def update
	end

	def destroy
	end
end
