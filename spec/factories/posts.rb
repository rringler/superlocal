# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
  	association :user
  	association :board
  	sequence(:title) { |n| "Post Test Title %04d" % n }
  	sequence(:link)  { |n| "http://www.test.com/link_%04d" % n }
  	text						 "Optional text"
  end
end
