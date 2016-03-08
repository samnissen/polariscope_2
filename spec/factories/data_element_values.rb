FactoryGirl.define do
  factory :data_element_value do
    encrypted_value SymmetricEncryption.encrypt("MyString")
    environment
    user
    data_element
  end

end
