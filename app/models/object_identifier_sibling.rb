class ObjectIdentifierSibling < ActiveRecord::Base
  belongs_to :object_identifier
  acts_as_list scope: :object_identifier
  belongs_to :sibling_relationship
  belongs_to :user

  validates :object_type_id, presence: true
  validates :selector_id, presence: true
  validates :sibling_relationship_id, presence: true
end
