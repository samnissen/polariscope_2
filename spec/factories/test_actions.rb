FactoryGirl.define do
  factory :test_action do
    name "MyString"
    description "MyString"
    testset
    activity
    sequence(:position)
    # position (0..999).to_a.sample
    pointer nil
    user
  end
end
