require 'rails_helper'

RSpec.describe "data_elements/edit", type: :view do
  before(:each) do
    @data_element = assign(:data_element, DataElement.create!(
      :key => "MyString",
      :value => "MyString",
      :environment => nil,
      :user => nil
    ))
  end

  it "renders the edit data_element form" do
    render

    assert_select "form[action=?][method=?]", data_element_path(@data_element), "post" do

      assert_select "input#data_element_key[name=?]", "data_element[key]"

      assert_select "input#data_element_value[name=?]", "data_element[value]"

      assert_select "input#data_element_environment_id[name=?]", "data_element[environment_id]"

      assert_select "input#data_element_user_id[name=?]", "data_element[user_id]"
    end
  end
end
