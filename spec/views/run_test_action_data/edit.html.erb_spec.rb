require 'rails_helper'

RSpec.describe "run_test_action_data/edit", type: :view do
  before(:each) do
    @run_test_action_datum = assign(:run_test_action_datum, RunTestActionDatum.create!(
      :data => "MyString",
      :run_object_identifier => nil
    ))
  end

  it "renders the edit run_test_action_datum form" do
    render

    assert_select "form[action=?][method=?]", run_test_action_datum_path(@run_test_action_datum), "post" do

      assert_select "input#run_test_action_datum_data[name=?]", "run_test_action_datum[data]"

      assert_select "input#run_test_action_datum_run_object_identifier_id[name=?]", "run_test_action_datum[run_object_identifier_id]"
    end
  end
end
