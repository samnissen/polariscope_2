class RunTestAction < ActiveRecord::Base
  belongs_to :test_action
  belongs_to :run
  belongs_to :activity
end
