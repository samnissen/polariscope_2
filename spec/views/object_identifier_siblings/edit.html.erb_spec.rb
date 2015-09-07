require 'rails_helper'

RSpec.describe "object_identifier_siblings/edit", type: :view do
  before(:each) do
    @object_identifier_sibling = assign(:object_identifier_sibling, ObjectIdentifierSibling.create!(
      :identifier => "MyString",
      :id_type => "MyString",
      :selector => "MyString",
      :object_identifier => nil,
      :sibling_relationship => nil,
      :user => nil
    ))
  end

  it "renders the edit object_identifier_sibling form" do
    render

    assert_select "form[action=?][method=?]", object_identifier_sibling_path(@object_identifier_sibling), "post" do

      assert_select "input#object_identifier_sibling_identifier[name=?]", "object_identifier_sibling[identifier]"

      assert_select "input#object_identifier_sibling_id_type[name=?]", "object_identifier_sibling[id_type]"

      assert_select "input#object_identifier_sibling_selector[name=?]", "object_identifier_sibling[selector]"

      assert_select "input#object_identifier_sibling_object_identifier_id[name=?]", "object_identifier_sibling[object_identifier_id]"

      assert_select "input#object_identifier_sibling_sibling_relationship_id[name=?]", "object_identifier_sibling[sibling_relationship_id]"

      assert_select "input#object_identifier_sibling_user_id[name=?]", "object_identifier_sibling[user_id]"
    end
  end
end
