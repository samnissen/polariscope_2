require 'rails_helper'

RSpec.describe "object_identifiers/show", type: :view do
  before(:each) do
    @object_identifier = assign(:object_identifier, ObjectIdentifier.create!(
      :identifier => "Identifier",
      :id_type => "Id Type",
      :selector => "Selector",
      :test_action => nil,
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
  end
end
