class PostsController < ApplicationController
	def new
		@post = Post.new
		@board = Board.where(id: params[:board_id]).first
	end

	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id

		if @post.save
			flash[:success] = "Created a new post!"
			redirect_to board(@post.board_id)
		else
			render 'new'
		end
	end

	def show
		@post = Post.where(id: params[:id]).first
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private

	def post_params
		params.require(:post).permit(:title, :link, :text, :board_id)
	end
end
