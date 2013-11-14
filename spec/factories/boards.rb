# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :board do
  	title 					"test_title"
  	description 		"test_board_title"
  	sequence(:slug) { |n| "test_board_slug_%04d" % n }
  end
end
