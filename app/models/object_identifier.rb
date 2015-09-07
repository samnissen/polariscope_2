class ObjectIdentifier < ActiveRecord::Base
  belongs_to :test_action
  belongs_to :user
end
