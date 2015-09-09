require 'rails_helper'

RSpec.describe "run_tests/index", type: :view do
  before(:each) do
    assign(:run_tests, [
      RunTest.create!(
        :name => "Name",
        :description => "Description",
        :belongs_to => "",
        :belongs_to => ""
      ),
      RunTest.create!(
        :name => "Name",
        :description => "Description",
        :belongs_to => "",
        :belongs_to => ""
      )
    ])
  end

  it "renders a list of run_tests" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
