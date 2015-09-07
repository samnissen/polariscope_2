require 'rails_helper'

RSpec.describe "run_test_actions/edit", type: :view do
  before(:each) do
    @run_test_action = assign(:run_test_action, RunTestAction.create!(
      :name => "MyString",
      :description => "MyString",
      :test_action => nil,
      :run => nil,
      :activity => nil,
      :additional_info => "MyString"
    ))
  end

  it "renders the edit run_test_action form" do
    render

    assert_select "form[action=?][method=?]", run_test_action_path(@run_test_action), "post" do

      assert_select "input#run_test_action_name[name=?]", "run_test_action[name]"

      assert_select "input#run_test_action_description[name=?]", "run_test_action[description]"

      assert_select "input#run_test_action_test_action_id[name=?]", "run_test_action[test_action_id]"

      assert_select "input#run_test_action_run_id[name=?]", "run_test_action[run_id]"

      assert_select "input#run_test_action_activity_id[name=?]", "run_test_action[activity_id]"

      assert_select "input#run_test_action_additional_info[name=?]", "run_test_action[additional_info]"
    end
  end
end
