require 'rails_helper'

RSpec.describe "test_statuses/new", type: :view do
  before(:each) do
    assign(:test_status, TestStatus.new(
      :run_test => nil,
      :browser_type => nil,
      :success => false,
      :notes => "MyString",
      :log => "MyText"
    ))
  end

  it "renders new test_status form" do
    render

    assert_select "form[action=?][method=?]", test_statuses_path, "post" do

      assert_select "input#test_status_run_test_id[name=?]", "test_status[run_test_id]"

      assert_select "input#test_status_browser_type_id[name=?]", "test_status[browser_type_id]"

      assert_select "input#test_status_success[name=?]", "test_status[success]"

      assert_select "input#test_status_notes[name=?]", "test_status[notes]"

      assert_select "textarea#test_status_log[name=?]", "test_status[log]"
    end
  end
end
