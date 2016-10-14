require 'rails_helper'

RSpec.describe "did_you_mean_types/show", type: :view do
  before(:each) do
    @did_you_mean_type = assign(:did_you_mean_type, DidYouMeanType.create!(
      :description => "Description",
      :key => "Key",
      :archived => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Key/)
    expect(rendered).to match(/false/)
  end
end
