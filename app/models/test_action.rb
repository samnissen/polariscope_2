class TestAction < ActiveRecord::Base
  belongs_to :testset
  belongs_to :activity
  belongs_to :user

  has_one :object_identifier
  has_one :test_action_datum

  acts_as_list scope: :testset

  validates :activity, presence: true
  validates :testset, presence: true
  validates :name, length: { in: 5..255 }
end
