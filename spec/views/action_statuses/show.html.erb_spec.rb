require 'rails_helper'

RSpec.describe "action_statuses/show", type: :view do
  before(:each) do
    @action_status = assign(:action_status, ActionStatus.create!(
      :run_test_action => nil,
      :browser_type => nil,
      :success => false,
      :notes => "Notes",
      :log => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Notes/)
    expect(rendered).to match(/MyText/)
  end
end
