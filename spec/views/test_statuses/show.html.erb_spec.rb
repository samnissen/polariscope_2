require 'rails_helper'

RSpec.describe "test_statuses/show", type: :view do
  before(:each) do
    @test_status = assign(:test_status, TestStatus.create!(
      :run_test => nil,
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
