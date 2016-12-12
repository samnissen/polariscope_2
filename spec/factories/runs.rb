FactoryGirl.define do
  factory :run do
    name "MyString"
    description "MyString"
    collection
    environment
    browsers { FactoryGirl.create_list(:browser_type, 3).map{|bt| "#{bt.key}".to_sym}.compact }
    test_ids [1,2,3]

    after(:build) { |run| run.class.skip_callback(:create, :before, :compile) }

    factory :run_with_compile do
      before(:create) do |run|
        testset1 = create(:testset, {:collection => run.collection})
        testset2 = create(:testset, {:collection => run.collection})
        run.test_ids = [testset1.id, testset2.id]
        ts1_test_actions = create_list(:test_action, 3, {testset: testset1})
        ts2_test_actions = create_list(:test_action, 3, {testset: testset2})
        (ts1_test_actions + ts2_test_actions).each do |ta|
          create(:object_identifier, {:test_action => ta})
        end
      end

      before(:create) { |run| run.send(:compile) }
    end
  end

end
