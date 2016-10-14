require 'rails_helper'

RSpec.describe "did_you_means/new", type: :view do
  before(:each) do
    assign(:did_you_mean, DidYouMean.new(
      :action_status => nil,
      :possibility => "MyString",
      :did_you_mean_type => nil
    ))
  end

  it "renders new did_you_mean form" do
    render

    assert_select "form[action=?][method=?]", did_you_means_path, "post" do

      assert_select "input#did_you_mean_action_status_id[name=?]", "did_you_mean[action_status_id]"

      assert_select "input#did_you_mean_possibility[name=?]", "did_you_mean[possibility]"

      assert_select "input#did_you_mean_did_you_mean_type_id[name=?]", "did_you_mean[did_you_mean_type_id]"
    end
  end
end
