class TestStatus < ActiveRecord::Base
  belongs_to :run_test
  belongs_to :browser_type

  validates :api_id, uniqueness: true, allow_nil: true
end
