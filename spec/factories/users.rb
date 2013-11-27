# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:username) 	{ |n| "Test_User%04d" % n }
    sequence(:email) 			{ |n| "Test_User%04d@gmail.com" % n }
    password 							"abcdef"
    password_confirmation "abcdef"

    factory :confirmed_user do
      confirmed_at        DateTime.now - 1.day
    end
  end
end
