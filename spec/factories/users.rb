# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:username) 	{ |n| "Test_User%04d" % n }
    sequence(:email) 			{ |n| "Test_User%04d@gmail.com" % n }
    password 							"Secure_Password"
    password_confirmation "Secure_Password"
  end
end
