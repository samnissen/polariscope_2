require 'rails_helper'

RSpec.describe "run_tests/show", type: :view do
  before(:each) do
    @run_test = assign(:run_test, RunTest.create!(
      :name => "Name",
      :description => "Description",
      :belongs_to => "",
      :belongs_to => ""
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
