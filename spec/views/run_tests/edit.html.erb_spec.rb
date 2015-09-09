require 'rails_helper'

RSpec.describe "run_tests/edit", type: :view do
  before(:each) do
    @run_test = assign(:run_test, RunTest.create!(
      :name => "MyString",
      :description => "MyString",
      :belongs_to => "",
      :belongs_to => ""
    ))
  end

  it "renders the edit run_test form" do
    render

    assert_select "form[action=?][method=?]", run_test_path(@run_test), "post" do

      assert_select "input#run_test_name[name=?]", "run_test[name]"

      assert_select "input#run_test_description[name=?]", "run_test[description]"

      assert_select "input#run_test_belongs_to[name=?]", "run_test[belongs_to]"

      assert_select "input#run_test_belongs_to[name=?]", "run_test[belongs_to]"
    end
  end
end
