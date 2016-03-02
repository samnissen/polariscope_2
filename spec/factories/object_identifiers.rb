FactoryGirl.define do
  factory :object_identifier do
    identifier "MyString"
    object_type
    selector
    test_action
    user
    position (0..999).to_a.sample
  end

# => #<ObjectIdentifier id: nil, identifier: nil, object_type_id: nil, selector_id: nil, test_action_id: nil, user_id: nil, created_at: nil, updated_at: nil, position: nil>
end
