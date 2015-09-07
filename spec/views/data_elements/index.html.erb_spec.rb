require 'rails_helper'

RSpec.describe "data_elements/index", type: :view do
  before(:each) do
    assign(:data_elements, [
      DataElement.create!(
        :key => "Key",
        :value => "Value",
        :environment => nil,
        :user => nil
      ),
      DataElement.create!(
        :key => "Key",
        :value => "Value",
        :environment => nil,
        :user => nil
      )
    ])
  end

  it "renders a list of data_elements" do
    render
    assert_select "tr>td", :text => "Key".to_s, :count => 2
    assert_select "tr>td", :text => "Value".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
