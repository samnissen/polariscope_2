require 'rails_helper'

RSpec.describe "scheduled_tests/new", type: :view do
  before(:each) do
    assign(:scheduled_test, ScheduledTest.new(
      :notes => "MyText",
      :collection => nil,
      :test_ids => "MyString",
      :next_test => "MyString",
      :recurring => 1
    ))
  end

  it "renders new scheduled_test form" do
    render

    assert_select "form[action=?][method=?]", scheduled_tests_path, "post" do

      assert_select "textarea#scheduled_test_notes[name=?]", "scheduled_test[notes]"

      assert_select "input#scheduled_test_collection_id[name=?]", "scheduled_test[collection_id]"

      assert_select "input#scheduled_test_test_ids[name=?]", "scheduled_test[test_ids]"

      assert_select "input#scheduled_test_next_test[name=?]", "scheduled_test[next_test]"

      assert_select "input#scheduled_test_recurring[name=?]", "scheduled_test[recurring]"
    end
  end
end
