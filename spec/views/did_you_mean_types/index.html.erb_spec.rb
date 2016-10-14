require 'rails_helper'

RSpec.describe "did_you_mean_types/index", type: :view do
  before(:each) do
    assign(:did_you_mean_types, [
      DidYouMeanType.create!(
        :description => "Description",
        :key => "Key",
        :archived => false
      ),
      DidYouMeanType.create!(
        :description => "Description",
        :key => "Key",
        :archived => false
      )
    ])
  end

  it "renders a list of did_you_mean_types" do
    render
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Key".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
