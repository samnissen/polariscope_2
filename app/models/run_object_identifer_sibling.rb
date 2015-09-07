class RunObjectIdentiferSibling < ActiveRecord::Base
  belongs_to :run_object_identifer
  belongs_to :sibling_relationship
end
