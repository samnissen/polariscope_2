require 'rails_helper'

RSpec.describe "test_action_data/new", type: :view do
  before(:each) do
    assign(:test_action_datum, TestActionDatum.new(
      :data => "MyString",
      :test_action => nil
    ))
  end

  it "renders new test_action_datum form" do
    render

    assert_select "form[action=?][method=?]", test_action_data_path, "post" do

      assert_select "input#test_action_datum_data[name=?]", "test_action_datum[data]"

      assert_select "input#test_action_datum_test_action_id[name=?]", "test_action_datum[test_action_id]"
    end
  end
end
