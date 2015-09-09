class AddTestActionToDataElement < ActiveRecord::Migration
  def change
    add_reference :data_elements, :test_action, index: true
  end
end
