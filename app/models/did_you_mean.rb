class DidYouMean < ActiveRecord::Base
  belongs_to :action_status
  belongs_to :did_you_mean_type
end
