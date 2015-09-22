require 'rails_helper'

RSpec.describe "run_test_action_data/new", type: :view do
  before(:each) do
    assign(:run_test_action_datum, RunTestActionDatum.new(
      :data => "MyString",
      :run_object_identifier => nil
    ))
  end

  it "renders new run_test_action_datum form" do
    render

    assert_select "form[action=?][method=?]", run_test_action_data_path, "post" do

      assert_select "input#run_test_action_datum_data[name=?]", "run_test_action_datum[data]"

      assert_select "input#run_test_action_datum_run_object_identifier_id[name=?]", "run_test_action_datum[run_object_identifier_id]"
    end
  end
end
