require 'rails_helper'

RSpec.describe "test_action_data/index", type: :view do
  before(:each) do
    assign(:test_action_data, [
      TestActionDatum.create!(
        :data => "Data",
        :test_action => nil
      ),
      TestActionDatum.create!(
        :data => "Data",
        :test_action => nil
      )
    ])
  end

  it "renders a list of test_action_data" do
    render
    assert_select "tr>td", :text => "Data".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
