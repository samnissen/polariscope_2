require 'rails_helper'

RSpec.describe "runs/edit", type: :view do
  before(:each) do
    @run = assign(:run, Run.create!(
      :name => "MyString",
      :description => "MyString",
      :collection => nil
    ))
  end

  it "renders the edit run form" do
    render

    assert_select "form[action=?][method=?]", run_path(@run), "post" do

      assert_select "input#run_name[name=?]", "run[name]"

      assert_select "input#run_description[name=?]", "run[description]"

      assert_select "input#run_collection_id[name=?]", "run[collection_id]"
    end
  end
end
