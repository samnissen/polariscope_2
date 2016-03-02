FactoryGirl.define do
  factory :run_test do
    name "MyString"
    description "MyString"
    run

    after(:build) { |run_test| run_test.class.skip_callback(:create, :before, :compile) }
  end

end
