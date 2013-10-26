class CommentsController < ApplicationController
	def new
		@comment = Comment.new
		@board = Board.where(params[:board_id]).first
		@post = Post.where(params[:post_id]).first
		@parent = Post.where(params[:parent_id]).first
	end

	def create
		@comment = Comment.new(comment_params)
		@comment.user_id = current_user.id

		if @comment.save
			flash[:success] = "Created a new comment!"
		end

		redirect_to board_post_path(@comment.post)
	end

	def show
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private

	def comment_params
		params.require(:comment).permit(:post_id, :text)
	end
end
