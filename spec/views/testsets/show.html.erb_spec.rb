require 'rails_helper'

RSpec.describe "testsets/show", type: :view do
  before(:each) do
    @testset = assign(:testset, Testset.create!(
      :name => "Name",
      :description => "Description",
      :collection => nil,
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
