class RunTestActionDatum < ActiveRecord::Base
  belongs_to :run_object_identifier
  belongs_to :test_action_datum
end
