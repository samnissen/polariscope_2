class ObjectIdentifier < ActiveRecord::Base
  belongs_to :test_action
  acts_as_list scope: :test_action
  belongs_to :user

  has_many :object_identifier_siblings, -> { order(position: :asc) }

  validates :object_type_id, presence: true
  validates :selector_id, presence: true
  validates :test_action_id, presence: true
end
