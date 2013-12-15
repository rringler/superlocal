class BoardsController < ApplicationController
	before_filter :authenticate_user!, only: [:create, :edit, :update]

	def create
		@board = Board.new(board_params)

		if @board.save
			redirect_to @board, flash: { success: "Created a new board!" }
		else
			render 'new'
		end
	end

	def show
		@board = Board.where(id: params[:id]).first.decorate
	end

	def find
		address = Address.new(address_params)
		slug    = AddressValidator.new(address).slug
		@board  = Board.where(slug: slug).first_or_initialize
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

	def address_params
		params.require(:address).permit(:address2, :city, :state, :zip5)
	end
end
