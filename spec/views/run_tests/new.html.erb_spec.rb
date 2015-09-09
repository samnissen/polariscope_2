require 'rails_helper'

RSpec.describe "run_tests/new", type: :view do
  before(:each) do
    assign(:run_test, RunTest.new(
      :name => "MyString",
      :description => "MyString",
      :belongs_to => "",
      :belongs_to => ""
    ))
  end

  it "renders new run_test form" do
    render

    assert_select "form[action=?][method=?]", run_tests_path, "post" do

      assert_select "input#run_test_name[name=?]", "run_test[name]"

      assert_select "input#run_test_description[name=?]", "run_test[description]"

      assert_select "input#run_test_belongs_to[name=?]", "run_test[belongs_to]"

      assert_select "input#run_test_belongs_to[name=?]", "run_test[belongs_to]"
    end
  end
end
