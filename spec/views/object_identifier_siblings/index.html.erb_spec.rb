require 'rails_helper'

RSpec.describe "object_identifier_siblings/index", type: :view do
  before(:each) do
    assign(:object_identifier_siblings, [
      ObjectIdentifierSibling.create!(
        :identifier => "Identifier",
        :id_type => "Id Type",
        :selector => "Selector",
        :object_identifier => nil,
        :sibling_relationship => nil,
        :user => nil
      ),
      ObjectIdentifierSibling.create!(
        :identifier => "Identifier",
        :id_type => "Id Type",
        :selector => "Selector",
        :object_identifier => nil,
        :sibling_relationship => nil,
        :user => nil
      )
    ])
  end

  it "renders a list of object_identifier_siblings" do
    render
    assert_select "tr>td", :text => "Identifier".to_s, :count => 2
    assert_select "tr>td", :text => "Id Type".to_s, :count => 2
    assert_select "tr>td", :text => "Selector".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
