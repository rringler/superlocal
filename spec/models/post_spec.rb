require 'spec_helper'

describe Post do
  it 'has valid factories' do
		FactoryGirl.create(:post).should be_valid
	end

	describe 'validations' do
		describe 'title' do
			it 'is present' do
				FactoryGirl.build(:post, title: nil).should_not be_valid
			end

			it 'is less than 255 characters' do
				FactoryGirl.build(:post, title: "a" * 256).should_not be_valid
			end
		end
	end
end
