require 'spec_helper'

describe User do
  it 'has valid factories' do
		FactoryGirl.create(:user).should be_valid
	end

	describe 'validations' do
		describe 'username' do
			it 'is present' do
				FactoryGirl.build(:user, username: nil).should_not be_valid
			end

			it 'is unique' do
				user1 = FactoryGirl.create(:user)
				user2 = FactoryGirl.build(:user, username: user1.username).should_not be_valid
			end

			it 'is not case sensitive' do
				user1 = FactoryGirl.create(:user)
				user2 = FactoryGirl.build(:user, username: user1.username.downcase).should_not be_valid
			end
		end

		describe 'email' do
			it 'cannot be nil' do
				FactoryGirl.build(:user, email: nil).should_not be_valid
			end

			it 'is unique' do
				user1 = FactoryGirl.create(:user)
				user2 = FactoryGirl.build(:user, email: user1.email).should_not be_valid
			end

			it 'is not case sensitive' do
				user1 = FactoryGirl.create(:user)
				user2 = FactoryGirl.build(:user, email: user1.email.downcase).should_not be_valid
			end
		end		
	end
end
