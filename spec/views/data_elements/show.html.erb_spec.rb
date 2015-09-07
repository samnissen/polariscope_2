require 'rails_helper'

RSpec.describe "data_elements/show", type: :view do
  before(:each) do
    @data_element = assign(:data_element, DataElement.create!(
      :key => "Key",
      :value => "Value",
      :environment => nil,
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Key/)
    expect(rendered).to match(/Value/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
