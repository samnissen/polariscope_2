require 'rails_helper'

RSpec.describe "testsets/edit", type: :view do
  before(:each) do
    @testset = assign(:testset, Testset.create!(
      :name => "MyString",
      :description => "MyString",
      :collection => nil,
      :user => nil
    ))
  end

  it "renders the edit testset form" do
    render

    assert_select "form[action=?][method=?]", testset_path(@testset), "post" do

      assert_select "input#testset_name[name=?]", "testset[name]"

      assert_select "input#testset_description[name=?]", "testset[description]"

      assert_select "input#testset_collection_id[name=?]", "testset[collection_id]"

      assert_select "input#testset_user_id[name=?]", "testset[user_id]"
    end
  end
end
