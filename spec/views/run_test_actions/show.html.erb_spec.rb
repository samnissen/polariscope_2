require 'rails_helper'

RSpec.describe "run_test_actions/show", type: :view do
  before(:each) do
    @run_test_action = assign(:run_test_action, RunTestAction.create!(
      :name => "Name",
      :description => "Description",
      :test_action => nil,
      :run => nil,
      :activity => nil,
      :additional_info => "Additional Info"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Additional Info/)
  end
end
