# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    address2 "1800 Cabrillo Memorial Dr."
    city     "San Diego"
    state    "CA"
    zip5     "92106"
  end
end
