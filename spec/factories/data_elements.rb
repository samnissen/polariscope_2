FactoryGirl.define do
  sequence(:key) { |n| "MyKey#{n}" }
  factory :data_element do
    key
    user
  end

end
