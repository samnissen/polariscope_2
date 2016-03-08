FactoryGirl.define do
  factory :run do
    name "MyString"
    description "MyString"
    collection
    environment
    browsers { FactoryGirl.create_list(:browser_type, 2).map{|bt| "#{bt.key}".to_sym}.compact }

    after(:build) { |run| run.class.skip_callback(:create, :before, :compile) }
  end

end
