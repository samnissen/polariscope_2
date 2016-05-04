require 'rails_helper'

RSpec.describe "scheduled_tests/index", type: :view do
  before(:each) do
    assign(:scheduled_tests, [
      ScheduledTest.create!(
        :notes => "MyText",
        :collection => nil,
        :test_ids => "Test Ids",
        :next_test => "Next Test",
        :recurring => 1
      ),
      ScheduledTest.create!(
        :notes => "MyText",
        :collection => nil,
        :test_ids => "Test Ids",
        :next_test => "Next Test",
        :recurring => 1
      )
    ])
  end

  it "renders a list of scheduled_tests" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Test Ids".to_s, :count => 2
    assert_select "tr>td", :text => "Next Test".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
