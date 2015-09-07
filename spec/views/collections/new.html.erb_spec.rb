require 'rails_helper'

RSpec.describe "collections/new", type: :view do
  before(:each) do
    assign(:collection, Collection.new(
      :user => nil,
      :name => "MyString",
      :description => "MyString"
    ))
  end

  it "renders new collection form" do
    render

    assert_select "form[action=?][method=?]", collections_path, "post" do

      assert_select "input#collection_user_id[name=?]", "collection[user_id]"

      assert_select "input#collection_name[name=?]", "collection[name]"

      assert_select "input#collection_description[name=?]", "collection[description]"
    end
  end
end
