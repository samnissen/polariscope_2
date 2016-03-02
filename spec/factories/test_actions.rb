FactoryGirl.define do
  factory :test_action do
    name "MyString"
    description "MyString"
    testset
    activity
    position (0..999).to_a.sample
    pointer nil
    user
  end
#  => #<TestAction id: 15, name: "Click the search icon", description: "", testset_id: 6, activity_id: 4, user_id: nil, created_at: "2015-11-04 17:15:52", updated_at: "2015-11-04 17:15:52", position: 3, pointer: nil>
end
