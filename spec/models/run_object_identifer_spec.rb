require 'rails_helper'

RSpec.describe RunObjectIdentifier, type: :model do
  it { should belong_to(:run_test_action) }
  # it { should belong_to(:user) }
  it { should belong_to(:object_type) }
  it { should belong_to(:selector) }
  it { should belong_to(:object_identifier) }

  it { should have_many(:run_object_identifier_siblings) }
  it { should have_many(:run_test_action_data) }

  before(:all) do
    [Run, RunTest, RunTestAction, RunObjectIdentifier].each do |klass|
      allow_any_instance_of(klass).to receive(:compile).and_return(true)
    end
  end

  it "return boolean for has_data_or_object?" do
    run_object_identifier = create(:run_object_identifier, :null_object)
    run_object_identifier.run_test_action_data.each {|d| d.destroy!}
    expect(run_object_identifier.has_data_or_object?).to be(false)

    run_object_identifier.run_test_action_data << create(:run_test_action_datum)
    expect(run_object_identifier.has_data_or_object?).to be(true)

    run_object_identifier.run_test_action_data.each {|d| d.destroy!}
    run_object_identifier.identifier = "This is not a null value!"
    run_object_identifier.save!
    expect(run_object_identifier.has_data_or_object?).to be(true)
  end

  it "return boolean for has_data?" do
    run_object_identifier = create(:run_object_identifier)
    run_object_identifier.run_test_action_data.each {|d| d.destroy!}
    expect(run_object_identifier.has_data?).to be(false)

    run_object_identifier.run_test_action_data << create(:run_test_action_datum)
    expect(run_object_identifier.has_data_or_object?).to be(true)
  end

  it "return boolean for placeholder?" do
    run_object_identifier = create(:run_object_identifier, :null_object)
    expect(run_object_identifier.placeholder?).to be(true)

    run_object_identifier.identifier = "This is not a null value!"
    run_object_identifier.save!
    expect(run_object_identifier.placeholder?).to be(false)
  end
end
