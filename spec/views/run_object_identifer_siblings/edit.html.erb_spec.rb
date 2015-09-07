require 'rails_helper'

RSpec.describe "run_object_identifer_siblings/edit", type: :view do
  before(:each) do
    @run_object_identifer_sibling = assign(:run_object_identifer_sibling, RunObjectIdentiferSibling.create!(
      :identifier => "MyString",
      :id_type => "MyString",
      :selector => "MyString",
      :run_object_identifer => nil,
      :sibling_relationship => nil
    ))
  end

  it "renders the edit run_object_identifer_sibling form" do
    render

    assert_select "form[action=?][method=?]", run_object_identifer_sibling_path(@run_object_identifer_sibling), "post" do

      assert_select "input#run_object_identifer_sibling_identifier[name=?]", "run_object_identifer_sibling[identifier]"

      assert_select "input#run_object_identifer_sibling_id_type[name=?]", "run_object_identifer_sibling[id_type]"

      assert_select "input#run_object_identifer_sibling_selector[name=?]", "run_object_identifer_sibling[selector]"

      assert_select "input#run_object_identifer_sibling_run_object_identifer_id[name=?]", "run_object_identifer_sibling[run_object_identifer_id]"

      assert_select "input#run_object_identifer_sibling_sibling_relationship_id[name=?]", "run_object_identifer_sibling[sibling_relationship_id]"
    end
  end
end
