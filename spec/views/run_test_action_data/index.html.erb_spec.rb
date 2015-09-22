require 'rails_helper'

RSpec.describe "run_test_action_data/index", type: :view do
  before(:each) do
    assign(:run_test_action_data, [
      RunTestActionDatum.create!(
        :data => "Data",
        :run_object_identifier => nil
      ),
      RunTestActionDatum.create!(
        :data => "Data",
        :run_object_identifier => nil
      )
    ])
  end

  it "renders a list of run_test_action_data" do
    render
    assert_select "tr>td", :text => "Data".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
