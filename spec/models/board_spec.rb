require 'spec_helper'

describe Board do
  it 'has valid factories' do
		FactoryGirl.create(:board).should be_valid
	end

	describe 'validations' do
		describe 'slug' do
			it 'is present' do
				FactoryGirl.build(:board, slug: nil).should_not be_valid
			end

			it 'is unique' do
				board1 = FactoryGirl.create(:board)
				board2 = FactoryGirl.build(:board, slug: board1.slug).should_not be_valid
			end
		end
	end

	describe 'followable' do
		it 'should be followable' do
			board = FactoryGirl.create(:board)
			user  = FactoryGirl.create(:user)

			user.follow(board)
			user.following?(board).should be_true
		end
	end
end
