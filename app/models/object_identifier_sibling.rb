class ObjectIdentifierSibling < ActiveRecord::Base
  belongs_to :object_identifier
  belongs_to :sibling_relationship
  belongs_to :user
end
