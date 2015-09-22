class AddObjectIdentifierToTestActionData < ActiveRecord::Migration
  def change
    add_reference :test_action_data, :object_identifier, index: true
  end
end
