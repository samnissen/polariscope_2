require 'rails_helper'

RSpec.describe "test_actions/edit", type: :view do
  before(:each) do
    @test_action = assign(:test_action, TestAction.create!(
      :name => "MyString",
      :description => "MyString",
      :testset => nil,
      :activity => nil,
      :additional_info => "MyString",
      :user => nil
    ))
  end

  it "renders the edit test_action form" do
    render

    assert_select "form[action=?][method=?]", test_action_path(@test_action), "post" do

      assert_select "input#test_action_name[name=?]", "test_action[name]"

      assert_select "input#test_action_description[name=?]", "test_action[description]"

      assert_select "input#test_action_testset_id[name=?]", "test_action[testset_id]"

      assert_select "input#test_action_activity_id[name=?]", "test_action[activity_id]"

      assert_select "input#test_action_additional_info[name=?]", "test_action[additional_info]"

      assert_select "input#test_action_user_id[name=?]", "test_action[user_id]"
    end
  end
end
