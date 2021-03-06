require 'rails_helper'

RSpec.describe "action_statuses/edit", type: :view do
  before(:each) do
    @action_status = assign(:action_status, ActionStatus.create!(
      :run_test_action => nil,
      :browser_type => nil,
      :success => false,
      :notes => "MyString",
      :log => "MyText"
    ))
  end

  it "renders the edit action_status form" do
    render

    assert_select "form[action=?][method=?]", action_status_path(@action_status), "post" do

      assert_select "input#action_status_run_test_action_id[name=?]", "action_status[run_test_action_id]"

      assert_select "input#action_status_browser_type_id[name=?]", "action_status[browser_type_id]"

      assert_select "input#action_status_success[name=?]", "action_status[success]"

      assert_select "input#action_status_notes[name=?]", "action_status[notes]"

      assert_select "textarea#action_status_log[name=?]", "action_status[log]"
    end
  end
end
