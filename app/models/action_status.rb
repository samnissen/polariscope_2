class ActionStatus < ActiveRecord::Base
  belongs_to :run_test_action
  belongs_to :browser_type
  has_many :did_you_means

  validates :api_id, uniqueness: true, allow_nil: true
end
