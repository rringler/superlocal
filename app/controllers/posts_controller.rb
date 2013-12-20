class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      flash[:success] = "Created a new post!"
      redirect_to board_post_path(@post.board, @post)
    else
      render 'new'
    end
  end

  def show
    @post = Post.where(id: params[:id]).first.decorate
    @board = @post.board.decorate
  end

  def edit
  end

  def update
    if @post.update_attributes(post_params)
      redirect_to board_post_path(@post.board, @post), flash: { success: "Post updated." }
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :link, :text, :board_id)
  end

  def correct_user
    @post = Post.where(id: params[:id]).first
    flash_params = { error: "You cannot edit this post." }
    redirect_to board_path(@post.board), flash: flash_params unless @post.user == current_user
  end
end
