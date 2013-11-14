class BoardsController < ApplicationController
	before_filter :authenticate_user!, only: [:create, :edit, :update]

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
		@board = Board.where(id: params[:id]).first
		@posts = @board.posts
	end

	def find
		@address = Address.new(params[:address])
		#@slug    = AddressService.new(@address).slug
		@slug 	 = 'test_value'
		@board   = Board.where(slug: @slug).first_or_initialize
		redirect_to @board unless @board.new_record?
	end

	def edit
		@board = Board.find(params[:id])
	end

	def update
	end

	private
	def board_params
		params.require(:board).permit(:title, :description, :slug)
	end
end
