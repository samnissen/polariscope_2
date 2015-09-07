require 'rails_helper'

RSpec.describe "test_actions/index", type: :view do
  before(:each) do
    assign(:test_actions, [
      TestAction.create!(
        :name => "Name",
        :description => "Description",
        :testset => nil,
        :activity => nil,
        :additional_info => "Additional Info",
        :user => nil
      ),
      TestAction.create!(
        :name => "Name",
        :description => "Description",
        :testset => nil,
        :activity => nil,
        :additional_info => "Additional Info",
        :user => nil
      )
    ])
  end

  it "renders a list of test_actions" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Additional Info".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
