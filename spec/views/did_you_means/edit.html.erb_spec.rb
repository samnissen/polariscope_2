require 'rails_helper'

RSpec.describe "did_you_means/edit", type: :view do
  before(:each) do
    @did_you_mean = assign(:did_you_mean, DidYouMean.create!(
      :action_status => nil,
      :possibility => "MyString",
      :did_you_mean_type => nil
    ))
  end

  it "renders the edit did_you_mean form" do
    render

    assert_select "form[action=?][method=?]", did_you_mean_path(@did_you_mean), "post" do

      assert_select "input#did_you_mean_action_status_id[name=?]", "did_you_mean[action_status_id]"

      assert_select "input#did_you_mean_possibility[name=?]", "did_you_mean[possibility]"

      assert_select "input#did_you_mean_did_you_mean_type_id[name=?]", "did_you_mean[did_you_mean_type_id]"
    end
  end
end
