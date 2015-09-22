require 'rails_helper'

RSpec.describe "run_test_action_data/show", type: :view do
  before(:each) do
    @run_test_action_datum = assign(:run_test_action_datum, RunTestActionDatum.create!(
      :data => "Data",
      :run_object_identifier => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Data/)
    expect(rendered).to match(//)
  end
end
