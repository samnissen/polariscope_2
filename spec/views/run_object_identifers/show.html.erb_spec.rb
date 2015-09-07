require 'rails_helper'

RSpec.describe "run_object_identifers/show", type: :view do
  before(:each) do
    @run_object_identifer = assign(:run_object_identifer, RunObjectIdentifer.create!(
      :identifier => "Identifier",
      :id_type => "Id Type",
      :selector => "Selector",
      :run_test_action => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Identifier/)
    expect(rendered).to match(/Id Type/)
    expect(rendered).to match(/Selector/)
    expect(rendered).to match(//)
  end
end
