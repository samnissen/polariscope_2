require 'rails_helper'

RSpec.describe "object_identifiers/index", type: :view do
  before(:each) do
    assign(:object_identifiers, [
      ObjectIdentifier.create!(
        :identifier => "Identifier",
        :id_type => "Id Type",
        :selector => "Selector",
        :test_action => nil,
        :user => nil
      ),
      ObjectIdentifier.create!(
        :identifier => "Identifier",
        :id_type => "Id Type",
        :selector => "Selector",
        :test_action => nil,
        :user => nil
      )
    ])
  end

  it "renders a list of object_identifiers" do
    render
    assert_select "tr>td", :text => "Identifier".to_s, :count => 2
    assert_select "tr>td", :text => "Id Type".to_s, :count => 2
    assert_select "tr>td", :text => "Selector".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
