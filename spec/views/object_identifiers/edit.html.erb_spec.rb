require 'rails_helper'

RSpec.describe "object_identifiers/edit", type: :view do
  before(:each) do
    @object_identifier = assign(:object_identifier, ObjectIdentifier.create!(
      :identifier => "MyString",
      :id_type => "MyString",
      :selector => "MyString",
      :test_action => nil,
      :user => nil
    ))
  end

  it "renders the edit object_identifier form" do
    render

    assert_select "form[action=?][method=?]", object_identifier_path(@object_identifier), "post" do

      assert_select "input#object_identifier_identifier[name=?]", "object_identifier[identifier]"

      assert_select "input#object_identifier_id_type[name=?]", "object_identifier[id_type]"

      assert_select "input#object_identifier_selector[name=?]", "object_identifier[selector]"

      assert_select "input#object_identifier_test_action_id[name=?]", "object_identifier[test_action_id]"

      assert_select "input#object_identifier_user_id[name=?]", "object_identifier[user_id]"
    end
  end
end
