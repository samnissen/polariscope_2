class DataElement < ActiveRecord::Base
  belongs_to :environment
  belongs_to :test_action
  acts_as_list scope: :test_action
  belongs_to :user
end
