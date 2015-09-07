require 'rails_helper'

RSpec.describe "object_identifier_siblings/show", type: :view do
  before(:each) do
    @object_identifier_sibling = assign(:object_identifier_sibling, ObjectIdentifierSibling.create!(
      :identifier => "Identifier",
      :id_type => "Id Type",
      :selector => "Selector",
      :object_identifier => nil,
      :sibling_relationship => nil,
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Identifier/)
    expect(rendered).to match(/Id Type/)
    expect(rendered).to match(/Selector/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
