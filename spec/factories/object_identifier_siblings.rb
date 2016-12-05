FactoryGirl.define do
  factory :object_identifier_sibling do
    selector
    identifier "MyString"
    object_type
    object_identifier
    sibling_relationship
    user
  end

end
