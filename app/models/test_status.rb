class TestStatus < ActiveRecord::Base
  belongs_to :run_test
  belongs_to :browser_type
end
