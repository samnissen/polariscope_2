class RemoveTestActionIdFromTestActionData < ActiveRecord::Migration
  def change
    remove_column :test_action_data, :test_action_id, :integer
  end
end
