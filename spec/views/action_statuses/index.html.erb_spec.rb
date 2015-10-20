require 'rails_helper'

RSpec.describe "action_statuses/index", type: :view do
  before(:each) do
    assign(:action_statuses, [
      ActionStatus.create!(
        :run_test_action => nil,
        :browser_type => nil,
        :success => false,
        :notes => "Notes",
        :log => "MyText"
      ),
      ActionStatus.create!(
        :run_test_action => nil,
        :browser_type => nil,
        :success => false,
        :notes => "Notes",
        :log => "MyText"
      )
    ])
  end

  it "renders a list of action_statuses" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Notes".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
