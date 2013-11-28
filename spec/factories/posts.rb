# Read about factories at https://github.com/thoughtbot/factory_girl
include BetterLorem

FactoryGirl.define do
  factory :post do
  	association :user
  	association :board
  	title       BetterLorem.w(8, true)
  	link        "http://bit.ly/#{BetterLorem.c(8, true)}"
  	text				BetterLorem.p(2, true)
  end
end
