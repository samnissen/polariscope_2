FactoryGirl.define do
  factory :browser_type do
    name "MyString"
    sequence(:key) { |n| "MyKey#{n}" }
    archived false
  end

end
