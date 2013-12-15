require 'spec_helper'
include Devise::TestHelpers

describe 'home page' do
	let(:address) do
		Address.new({
			address2: "1800 Cabrillo Memorial Dr.",
			city:     "San Diego",
			state:    "CA",
			zip5:     "92106" })
	end

	before(:each) do
		# stub out the AddressService.slug method to avoid USPS API hit
		AddressValidator.any_instance.stub(:slug)
										.and_return("1800-cabrillo-memorial-dr-92106")

		visit root_path
	end

	context 'when the user is signed in' do
		before(:each) do
			@user = FactoryGirl.create(:confirmed_user)

			fill_in 'user_login',    with: @user.username
			fill_in 'user_password', with: @user.password

			click_button 'Sign in'

			visit root_path
		end

		context 'and searches for a board' do
			context 'and the board exists' do
				before(:each) do
					@board = Board.create({ title:       "Cabrillo National Monument",
																	description: "1800 Cabrillo Memorial Dr., San Diego, CA 92106",
																	slug:        "1800-cabrillo-memorial-dr-92106" })

					fill_in 'address[address2]', with: "#{address.address2}"
					fill_in 'address[city]',     with: "#{address.city}"
					fill_in 'address[state]',    with: "#{address.state}"
					fill_in 'address[zip5]',     with: "#{address.zip5}"

					click_button 'Find'
				end

				it 'should redirect to board#show' do
					page.should have_css("h2", text: @board.title)
					page.should have_css("h4", text: @board.description)
				end
			end

			context 'and the board does not exist' do
				before(:each) do
					fill_in 'address[address2]', with: "#{address.address2}"
					fill_in 'address[city]',     with: "#{address.city}"
					fill_in 'address[state]',    with: "#{address.state}"
					fill_in 'address[zip5]',     with: "#{address.zip5}"

					click_button 'Find'
				end

				it 'should indicate that the board does not exist' do
					page.should have_css("h2", text: "This locale does not exist.")
				end

				it 'should offer to create the board' do
					page.should have_css("h2", text: "Would you like to create it?")
					page.should have_css("input#board_title")
					page.should have_css("input#board_description")
				end
			end
		end
	end

	context 'when the user is not signed in' do
		context 'and searches for a board' do
			context 'and the board exists' do
				before(:each) do
					@board = Board.create({ title:       "Cabrillo National Monument",
																	description: "1800 Cabrillo Memorial Dr., San Diego, CA 92106",
																	slug:        "1800-cabrillo-memorial-dr-92106" })

					fill_in 'address[address2]', with: "#{address.address2}"
					fill_in 'address[city]',     with: "#{address.city}"
					fill_in 'address[state]',    with: "#{address.state}"
					fill_in 'address[zip5]',     with: "#{address.zip5}"

					click_button 'Find'
				end

				it 'should redirect to board#show' do
					page.should have_css("h2", text: @board.title)
					page.should have_css("h4", text: @board.description)
				end
			end

			context 'and the board does not exist' do
				before(:each) do
					fill_in 'address[address2]', with: "#{address.address2}"
					fill_in 'address[city]',     with: "#{address.city}"
					fill_in 'address[state]',    with: "#{address.state}"
					fill_in 'address[zip5]',     with: "#{address.zip5}"

					click_button 'Find'
				end

				it 'should indicate that the board does not exist' do
					page.should have_css("h2", text: "This locale does not exist.")
				end

				it 'should not offer to create the board' do
					page.should have_css("h2", text: "If you had an account, you could create it.")
					page.should_not have_css("input#board_title")
				end
			end
		end
	end
end