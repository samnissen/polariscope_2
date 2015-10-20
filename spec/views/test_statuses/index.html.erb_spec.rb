require 'rails_helper'

RSpec.describe "test_statuses/index", type: :view do
  before(:each) do
    assign(:test_statuses, [
      TestStatus.create!(
        :run_test => nil,
        :browser_type => nil,
        :success => false,
        :notes => "Notes",
        :log => "MyText"
      ),
      TestStatus.create!(
        :run_test => nil,
        :browser_type => nil,
        :success => false,
        :notes => "Notes",
        :log => "MyText"
      )
    ])
  end

  it "renders a list of test_statuses" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Notes".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
