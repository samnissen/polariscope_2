class XDidYouMean < ActiveRecord::Base
  belongs_to :action_status
  belongs_to :did_you_mean_type

  validates :action_status, :presence => true
  validates :did_you_mean_type, :presence => true
end
