class TestActionDatum < ActiveRecord::Base
  belongs_to :object_identifier
  belongs_to :data_element

  acts_as_list scope: :object_identifier
end
