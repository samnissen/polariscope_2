FactoryGirl.define do
  factory :run do
    name "MyString"
    description "MyString"
    collection
    environment
    browsers "my_browsers"

    after(:build) { |run| run.class.skip_callback(:create, :before, :compile) }
  end

end
