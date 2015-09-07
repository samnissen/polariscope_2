require 'rails_helper'

RSpec.describe "environments/index", type: :view do
  before(:each) do
    assign(:environments, [
      Environment.create!(
        :name => "Name",
        :user => nil
      ),
      Environment.create!(
        :name => "Name",
        :user => nil
      )
    ])
  end

  it "renders a list of environments" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
