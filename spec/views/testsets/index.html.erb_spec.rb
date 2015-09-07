require 'rails_helper'

RSpec.describe "testsets/index", type: :view do
  before(:each) do
    assign(:testsets, [
      Testset.create!(
        :name => "Name",
        :description => "Description",
        :collection => nil,
        :user => nil
      ),
      Testset.create!(
        :name => "Name",
        :description => "Description",
        :collection => nil,
        :user => nil
      )
    ])
  end

  it "renders a list of testsets" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
