require 'rails_helper'

RSpec.describe "run_object_identifers/edit", type: :view do
  before(:each) do
    @run_object_identifer = assign(:run_object_identifer, RunObjectIdentifer.create!(
      :identifier => "MyString",
      :id_type => "MyString",
      :selector => "MyString",
      :run_test_action => nil
    ))
  end

  it "renders the edit run_object_identifer form" do
    render

    assert_select "form[action=?][method=?]", run_object_identifer_path(@run_object_identifer), "post" do

      assert_select "input#run_object_identifer_identifier[name=?]", "run_object_identifer[identifier]"

      assert_select "input#run_object_identifer_id_type[name=?]", "run_object_identifer[id_type]"

      assert_select "input#run_object_identifer_selector[name=?]", "run_object_identifer[selector]"

      assert_select "input#run_object_identifer_run_test_action_id[name=?]", "run_object_identifer[run_test_action_id]"
    end
  end
end
