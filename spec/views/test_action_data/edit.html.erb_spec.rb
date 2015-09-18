require 'rails_helper'

RSpec.describe "test_action_data/edit", type: :view do
  before(:each) do
    @test_action_datum = assign(:test_action_datum, TestActionDatum.create!(
      :data => "MyString",
      :test_action => nil
    ))
  end

  it "renders the edit test_action_datum form" do
    render

    assert_select "form[action=?][method=?]", test_action_datum_path(@test_action_datum), "post" do

      assert_select "input#test_action_datum_data[name=?]", "test_action_datum[data]"

      assert_select "input#test_action_datum_test_action_id[name=?]", "test_action_datum[test_action_id]"
    end
  end
end
