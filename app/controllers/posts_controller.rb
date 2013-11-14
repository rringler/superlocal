class PostsController < ApplicationController
	before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
	def new
		@post = Post.new
		@board = Board.where(id: params[:board_id]).first
	end

	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id

		if @post.save
			flash[:success] = "Created a new post!"
			redirect_to board_path(@post.board)
		else
			render 'new'
		end
	end

	def show
		@post = Post.where(id: params[:id]).first
		@comments = @post.comments
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
