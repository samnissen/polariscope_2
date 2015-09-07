require 'rails_helper'

RSpec.describe "testsets/new", type: :view do
  before(:each) do
    assign(:testset, Testset.new(
      :name => "MyString",
      :description => "MyString",
      :collection => nil,
      :user => nil
    ))
  end

  it "renders new testset form" do
    render

    assert_select "form[action=?][method=?]", testsets_path, "post" do

      assert_select "input#testset_name[name=?]", "testset[name]"

      assert_select "input#testset_description[name=?]", "testset[description]"

      assert_select "input#testset_collection_id[name=?]", "testset[collection_id]"

      assert_select "input#testset_user_id[name=?]", "testset[user_id]"
    end
  end
end
