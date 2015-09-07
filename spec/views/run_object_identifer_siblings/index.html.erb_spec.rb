require 'rails_helper'

RSpec.describe "run_object_identifer_siblings/index", type: :view do
  before(:each) do
    assign(:run_object_identifer_siblings, [
      RunObjectIdentiferSibling.create!(
        :identifier => "Identifier",
        :id_type => "Id Type",
        :selector => "Selector",
        :run_object_identifer => nil,
        :sibling_relationship => nil
      ),
      RunObjectIdentiferSibling.create!(
        :identifier => "Identifier",
        :id_type => "Id Type",
        :selector => "Selector",
        :run_object_identifer => nil,
        :sibling_relationship => nil
      )
    ])
  end

  it "renders a list of run_object_identifer_siblings" do
    render
    assert_select "tr>td", :text => "Identifier".to_s, :count => 2
    assert_select "tr>td", :text => "Id Type".to_s, :count => 2
    assert_select "tr>td", :text => "Selector".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
