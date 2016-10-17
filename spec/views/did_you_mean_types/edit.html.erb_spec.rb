require 'rails_helper'

RSpec.describe "did_you_mean_types/edit", type: :view do
  before(:each) do
    @did_you_mean_type = assign(:did_you_mean_type, DidYouMeanType.create!(
      :description => "MyString",
      :key => "MyString",
      :archived => false
    ))
  end

  it "renders the edit did_you_mean_type form" do
    render

    assert_select "form[action=?][method=?]", did_you_mean_type_path(@did_you_mean_type), "post" do

      assert_select "input#did_you_mean_type_description[name=?]", "did_you_mean_type[description]"

      assert_select "input#did_you_mean_type_key[name=?]", "did_you_mean_type[key]"

      assert_select "input#did_you_mean_type_archived[name=?]", "did_you_mean_type[archived]"
    end
  end
end
