require 'rails_helper'

RSpec.describe "run_object_identifers/index", type: :view do
  before(:each) do
    assign(:run_object_identifers, [
      RunObjectIdentifer.create!(
        :identifier => "Identifier",
        :id_type => "Id Type",
        :selector => "Selector",
        :run_test_action => nil
      ),
      RunObjectIdentifer.create!(
        :identifier => "Identifier",
        :id_type => "Id Type",
        :selector => "Selector",
        :run_test_action => nil
      )
    ])
  end

  it "renders a list of run_object_identifers" do
    render
    assert_select "tr>td", :text => "Identifier".to_s, :count => 2
    assert_select "tr>td", :text => "Id Type".to_s, :count => 2
    assert_select "tr>td", :text => "Selector".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
