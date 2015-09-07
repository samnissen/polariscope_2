require 'rails_helper'

RSpec.describe "runs/index", type: :view do
  before(:each) do
    assign(:runs, [
      Run.create!(
        :name => "Name",
        :description => "Description",
        :collection => nil
      ),
      Run.create!(
        :name => "Name",
        :description => "Description",
        :collection => nil
      )
    ])
  end

  it "renders a list of runs" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
