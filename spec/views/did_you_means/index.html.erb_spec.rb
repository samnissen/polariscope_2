require 'rails_helper'

RSpec.describe "did_you_means/index", type: :view do
  before(:each) do
    assign(:did_you_means, [
      DidYouMean.create!(
        :action_status => nil,
        :possibility => "Possibility",
        :did_you_mean_type => nil
      ),
      DidYouMean.create!(
        :action_status => nil,
        :possibility => "Possibility",
        :did_you_mean_type => nil
      )
    ])
  end

  it "renders a list of did_you_means" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Possibility".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
