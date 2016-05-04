require 'rails_helper'

RSpec.describe "scheduled_tests/edit", type: :view do
  before(:each) do
    @scheduled_test = assign(:scheduled_test, ScheduledTest.create!(
      :notes => "MyText",
      :collection => nil,
      :test_ids => "MyString",
      :next_test => "MyString",
      :recurring => 1
    ))
  end

  it "renders the edit scheduled_test form" do
    render

    assert_select "form[action=?][method=?]", scheduled_test_path(@scheduled_test), "post" do

      assert_select "textarea#scheduled_test_notes[name=?]", "scheduled_test[notes]"

      assert_select "input#scheduled_test_collection_id[name=?]", "scheduled_test[collection_id]"

      assert_select "input#scheduled_test_test_ids[name=?]", "scheduled_test[test_ids]"

      assert_select "input#scheduled_test_next_test[name=?]", "scheduled_test[next_test]"

      assert_select "input#scheduled_test_recurring[name=?]", "scheduled_test[recurring]"
    end
  end
end
