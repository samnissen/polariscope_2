class TestActionDatum < ActiveRecord::Base
  belongs_to :test_action
  belongs_to :data_element
end
