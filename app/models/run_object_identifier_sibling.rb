class RunObjectIdentifierSibling < ActiveRecord::Base
  belongs_to :run_object_identifier
  belongs_to :sibling_relationship

  belongs_to :object_type
  belongs_to :selector
  belongs_to :object_identifier_sibling
end
