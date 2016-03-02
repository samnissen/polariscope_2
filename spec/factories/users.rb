FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    # email "#{SecureRandom.hex}@rakuten.com"
    password "1x2y3z1a2b3c"
    password_confirmation { "1x2y3z1a2b3c" }
  end
end
