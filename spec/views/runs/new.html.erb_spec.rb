require 'rails_helper'

RSpec.describe "runs/new", type: :view do
  before(:each) do
    assign(:run, Run.new(
      :name => "MyString",
      :description => "MyString",
      :collection => nil
    ))
  end

  it "renders new run form" do
    render

    assert_select "form[action=?][method=?]", runs_path, "post" do

      assert_select "input#run_name[name=?]", "run[name]"

      assert_select "input#run_description[name=?]", "run[description]"

      assert_select "input#run_collection_id[name=?]", "run[collection_id]"
    end
  end
end
