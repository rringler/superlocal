# Read about factories at https://github.com/thoughtbot/factory_girl
include BetterLorem

FactoryGirl.define do
  factory :board do
    title           "Cabrillo National Monument"
    description     "1800 Cabrillo Memorial Dr., San Diego, CA 92106"
    slug            "1800-cabrillo-memorial-dr-92106"
  end

  factory :unique_board do
    title           BetterLorem.w(5, true)
    description     BetterLorem.p(2, true)
    sequence(:slug) { |n| "test_board_slug_%04d" % n }
  end
end
