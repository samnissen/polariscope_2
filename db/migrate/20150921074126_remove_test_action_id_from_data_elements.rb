class RemoveTestActionIdFromDataElements < ActiveRecord::Migration
  def change
    remove_column :data_elements, :test_action_id, :integer
  end
end
