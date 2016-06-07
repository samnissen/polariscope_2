require 'rails_helper'

RSpec.describe "scheduled_tests/show", type: :view do
  before(:each) do
    @scheduled_test = assign(:scheduled_test, ScheduledTest.create!(
      :notes => "MyText",
      :collection => nil,
      :test_ids => "Test Ids",
      :next_test => "Next Test",
      :recurring => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Test Ids/)
    expect(rendered).to match(/Next Test/)
    expect(rendered).to match(/1/)
  end
end
