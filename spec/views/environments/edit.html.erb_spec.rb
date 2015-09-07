require 'rails_helper'

RSpec.describe "environments/edit", type: :view do
  before(:each) do
    @environment = assign(:environment, Environment.create!(
      :name => "MyString",
      :user => nil
    ))
  end

  it "renders the edit environment form" do
    render

    assert_select "form[action=?][method=?]", environment_path(@environment), "post" do

      assert_select "input#environment_name[name=?]", "environment[name]"

      assert_select "input#environment_user_id[name=?]", "environment[user_id]"
    end
  end
end
