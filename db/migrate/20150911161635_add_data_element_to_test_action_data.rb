class AddDataElementToTestActionData < ActiveRecord::Migration
  def change
    add_reference :test_action_data, :data_element, index: true
  end
end
