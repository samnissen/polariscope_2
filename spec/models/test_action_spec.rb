require 'rails_helper'

RSpec.describe TestAction, type: :model do
  it { should belong_to(:testset) }
  it { should belong_to(:activity) }
  it { should belong_to(:user) }
  it { should have_one(:object_identifier) }

  before(:each) do
    @test_action = create(:test_action)
  end

  describe "pointer_points_to_testset" do
    it "return true when pointer points to existing testset" do
      @testset = create(:testset)
      @test_action.pointer = @testset.id
      expect{@testset.save!}.not_to raise_error
    end
    it "prevents save when pointer points to existing testset" do
      testset = create(:testset)
      test_action = build(:test_action, pointer: ("#{testset.id}".to_i + 9999))
      expect{test_action.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "prevent_points_to_self" do
    it "prevents save when pointing to self" do
      testset_a = create(:testset)
      testset_b = create(:testset)
      test_action_a = build(:test_action, testset: testset_a, pointer: testset_a.id)
      expect{test_action_a.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "prevent_infinite_pointing" do
    it "return true when infinite loop does not exist" do
      testset_a = create(:testset)
      testset_b = create(:testset)
      test_action_a = build(:test_action, testset: testset_a, pointer: testset_b.id)
      test_action_b = create(:test_action, testset: testset_b)
      expect{test_action_a.save!}.not_to raise_error
    end

    it "prevents save when infinite loop exists" do
      testset_a = create(:testset)
      testset_b = create(:testset)
      testset_c = create(:testset)
      test_action_a = create(:test_action, testset: testset_a, pointer: testset_b.id)
      test_action_a = create(:test_action, testset: testset_b, pointer: testset_c.id)
      test_action_c = build(:test_action, testset: testset_c, pointer: testset_a.id)
      expect{test_action_c.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "clear_pointer_data" do
    it "action data is cleared when pointer exists" do
      activity = create(:activity)
      ta = create(:test_action, activity: activity, name: "SHOULDnotEXIST", description: "SHOULDnotEXIST", activity: activity)

      testset = create(:testset)
      ta.pointer = testset.id
      ta.save!

      expect(ta.name).to eq(nil)
      expect(ta.description).to eq(nil)
      expect(ta.activity).to eq(nil)
    end
    it "action data is not cleared when pointer does not exist" do
      activity = create(:activity)
      ta = create(:test_action, activity: activity, name: "SHOULDexist", description: "SHOULDexist", activity: activity)

      expect(ta.name).to eq("SHOULDexist")
      expect(ta.description).to eq("SHOULDexist")
      expect(ta.activity).to eq(activity)
    end
  end

  describe "manage_identifiers" do
    it "creates a blank object if object is not required and data is required" do
      object_type = create(:object_type, type_name: "n/a")
      selector = create(:selector, selector_name: "n/a")
      activity = create(:activity, object_required: false, data_required: true)
      test_action = create(:test_action, activity: activity)

      expect(test_action.object_identifier).to be_present
      expect(test_action.object_identifier.object_type.type_name).to eq("n/a")
      expect(test_action.object_identifier.selector.selector_name).to eq("n/a")
      expect(test_action.object_identifier.identifier).to eq("null")
    end
    it "does not create object if no object or data is required" do
      activity = create(:activity, object_required: false, data_required: false)
      test_action = create(:test_action, activity: activity)
      expect(test_action.object_identifier).not_to be_present
    end
    it "does not create object if object is required" do
      activity = create(:activity, object_required: true, data_required: true)
      test_action = create(:test_action, activity: activity)

      expect(test_action.object_identifier).not_to be_present
    end
  end

  describe "duplicate_action" do
    it "copies a given test action without object identifier" do
      user = create(:user)
      testset = create(:testset)
      activity = create(:activity, object_required: false, data_required: false)
      test_action = create(:test_action, activity: activity, user: create(:user), name: "Tango")

      new_test_action = TestAction.duplicate_action(test_action, user, testset)

      expect(new_test_action.activity).to eq(test_action.activity)
      expect(new_test_action.user).to eq(user)
      expect(new_test_action.name).to eq(test_action.name)

      expect(new_test_action.object_identifier).not_to be_present
    end
    it "copies a given test action with object identifier" do
      user = create(:user)
      testset = create(:testset)
      activity = create(:activity, object_required: true, data_required: true)
      test_action = create(:test_action, activity: activity, user: create(:user), name: "Tango")
      test_action.object_identifier = create(:object_identifier, selector: create(:selector), object_type: create(:object_type), identifier: "hello!")

      new_test_action = TestAction.duplicate_action(test_action, user, testset)

      expect(new_test_action.activity).to eq(test_action.activity)
      expect(new_test_action.user).to eq(user)
      expect(new_test_action.name).to eq(test_action.name)

      expect(new_test_action.object_identifier.identifier).to eq(test_action.object_identifier.identifier)
      expect(new_test_action.object_identifier.selector).to eq(test_action.object_identifier.selector)
      expect(new_test_action.object_identifier.object_type).to eq(test_action.object_identifier.object_type)
    end
  end

end
