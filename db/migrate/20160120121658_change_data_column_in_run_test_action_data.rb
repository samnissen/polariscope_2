class ChangeDataColumnInRunTestActionData < ActiveRecord::Migration
  def change
    change_column :run_test_action_data, :data, :text, :limit => 64.kilobytes - 1
  end
end
