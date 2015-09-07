require 'rails_helper'

RSpec.describe "run_object_identifer_siblings/show", type: :view do
  before(:each) do
    @run_object_identifer_sibling = assign(:run_object_identifer_sibling, RunObjectIdentiferSibling.create!(
      :identifier => "Identifier",
      :id_type => "Id Type",
      :selector => "Selector",
      :run_object_identifer => nil,
      :sibling_relationship => nil
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
