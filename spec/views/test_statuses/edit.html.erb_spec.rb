require 'rails_helper'

RSpec.describe "test_statuses/edit", type: :view do
  before(:each) do
    @test_status = assign(:test_status, TestStatus.create!(
      :run_test => nil,
      :browser_type => nil,
      :success => false,
      :notes => "MyString",
      :log => "MyText"
    ))
  end

  it "renders the edit test_status form" do
    render

    assert_select "form[action=?][method=?]", test_status_path(@test_status), "post" do

      assert_select "input#test_status_run_test_id[name=?]", "test_status[run_test_id]"

      assert_select "input#test_status_browser_type_id[name=?]", "test_status[browser_type_id]"

      assert_select "input#test_status_success[name=?]", "test_status[success]"

      assert_select "input#test_status_notes[name=?]", "test_status[notes]"

      assert_select "textarea#test_status_log[name=?]", "test_status[log]"
    end
  end
end
