require 'rails_helper'

RSpec.describe DataElementValue, type: :model do
  it "creates a valid Data Element Value" do
    expect{create(:data_element_value)}.not_to raise_error
  end

  it "rejects invalid Data Element Value" do
    expect {
      create(:data_element_value, user: nil, data_element: nil, environment: nil)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "only allows one value per environment and variable name" do
    env = create(:environment)
    user = create(:user)
    var_name = SymmetricEncryption.encrypt("Hello New World")
    data_element = create(:data_element)
    first = create(:data_element_value, environment: env, user: user, encrypted_value: var_name, data_element: data_element)

    expect{
      second = create(:data_element_value, environment: env, user: user, encrypted_value: var_name, data_element: data_element)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "requires either a value or random_value to be selected" do
    expect{
      create(:data_element_value, value: nil, random_value: false)
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "wipes away the value if random is selected" do
    dev = create(:data_element_value, value: 'abcdefghijkl')
    dev.random_value = true
    dev.save!
    dev.reload

    expect(dev.value).to eq(nil)
  end
end
