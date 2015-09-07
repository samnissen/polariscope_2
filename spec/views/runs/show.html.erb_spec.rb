require 'rails_helper'

RSpec.describe "runs/show", type: :view do
  before(:each) do
    @run = assign(:run, Run.create!(
      :name => "Name",
      :description => "Description",
      :collection => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(//)
  end
end
