class BoardsController < ApplicationController
	def new
		@board = Board.new
	end

	def create
		@board = Board.new(board_params)
		if @board.save
			flash[:success] = "Created a new board!"
			redirect_to @board
		else
			render 'new'
		end
	end

	def show
		@board = Board.find(params[:id])
	end

	def find
		@board = Board.find(params[:address])
		redirect_to @board
	end

	def edit
		@board = Board.find(params[:id])
	end

	def update
	end

	private
	def board_params
		params.require(:board).permit(:title, :description)
	end
end
