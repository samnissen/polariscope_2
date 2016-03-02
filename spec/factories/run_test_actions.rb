FactoryGirl.define do
  factory :run_test_action do
    name "MyString"
    description "MyString"
    test_action nil
    activity
    run_test

    after(:build) { |run_test_action| run_test_action.class.skip_callback(:create, :before, :compile) }
  end

end
