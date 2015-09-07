require 'rails_helper'

RSpec.describe "run_test_actions/index", type: :view do
  before(:each) do
    assign(:run_test_actions, [
      RunTestAction.create!(
        :name => "Name",
        :description => "Description",
        :test_action => nil,
        :run => nil,
        :activity => nil,
        :additional_info => "Additional Info"
      ),
      RunTestAction.create!(
        :name => "Name",
        :description => "Description",
        :test_action => nil,
        :run => nil,
        :activity => nil,
        :additional_info => "Additional Info"
      )
    ])
  end

  it "renders a list of run_test_actions" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Additional Info".to_s, :count => 2
  end
end
