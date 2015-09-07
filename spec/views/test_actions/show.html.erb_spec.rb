require 'rails_helper'

RSpec.describe "test_actions/show", type: :view do
  before(:each) do
    @test_action = assign(:test_action, TestAction.create!(
      :name => "Name",
      :description => "Description",
      :testset => nil,
      :activity => nil,
      :additional_info => "Additional Info",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Additional Info/)
    expect(rendered).to match(//)
  end
end
