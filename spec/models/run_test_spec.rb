require 'rails_helper'

RSpec.describe RunTest, type: :model do
  before(:all) do
    allow_any_instance_of(Run).to receive(:compile).and_return(true)
    allow_any_instance_of(RunTest).to receive(:compile).and_return(true)
  end

  it "creates a basic valid RunTest" do
    expect{ create(:run_test) }.not_to raise_error
  end

  it "builds test_actions without pointers" do
    testset = create(:testset)
    test_action = create(:test_action, testset: testset)

    run = create(:run)
    run_test = create(:run_test, testset: testset, run: run)
    run_test.send(:compile_test_actions)

    expect(run_test.run_test_actions.size).to eq(testset.test_actions.size)
  end

  it "pulls test_actions from pointed-to testset" do
    pointed_to_testset = create(:testset)
    pointed_to_testset_test_action_1 = create(:test_action, testset: pointed_to_testset)
    pointed_to_testset_test_action_2 = create(:test_action, testset: pointed_to_testset)

    pointer_testset = create(:testset)
    pointer_test_action = create(:test_action, pointer: pointed_to_testset.id, testset: pointer_testset)

    run = create(:run)
    run_test = create(:run_test, testset: pointer_testset, run: run)
    run_test.send(:compile_test_actions)

    expect(run_test.run_test_actions.size).to eq(pointed_to_testset.test_actions.size)
  end

  pending "write test for escape_jquery_html_characters function"
end
