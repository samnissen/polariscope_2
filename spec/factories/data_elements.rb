FactoryGirl.define do
  factory :data_element do
    sequence(:key) { |n| "MyKey#{n}" }
    user
  end

end
