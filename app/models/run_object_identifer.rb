class RunObjectIdentifer < ActiveRecord::Base
  belongs_to :run_test_action

  belongs_to :user

  has_many :run_object_identifier_siblings

  has_many :run_test_aciton_data
end
