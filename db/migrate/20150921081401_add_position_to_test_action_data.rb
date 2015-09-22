class AddPositionToTestActionData < ActiveRecord::Migration
  def change
    add_column :test_action_data, :position, :integer
  end
end
