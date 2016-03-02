FactoryGirl.define do
  factory :run_object_identifier do
    identifier "MyString"
    run_test_action
    object_type
    selector
  end

  trait :null_object do
    identifier "null"
    association :object_type, type_name: "n/a"
    association :selector, selector_name: "n/a"
  end

  # trait :null_data do
    # run_test_action_data
  # end

  after(:build) { |run_object_identifier| run_object_identifier.class.skip_callback(:create, :before, :compile) }
end
