require 'rails_helper'

RSpec.describe "test_action_data/show", type: :view do
  before(:each) do
    @test_action_datum = assign(:test_action_datum, TestActionDatum.create!(
      :data => "Data",
      :test_action => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Data/)
    expect(rendered).to match(//)
  end
end
