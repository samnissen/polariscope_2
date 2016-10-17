require 'rails_helper'

RSpec.describe "did_you_means/show", type: :view do
  before(:each) do
    @did_you_mean = assign(:did_you_mean, DidYouMean.create!(
      :action_status => nil,
      :possibility => "Possibility",
      :did_you_mean_type => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Possibility/)
    expect(rendered).to match(//)
  end
end
