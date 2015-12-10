class ChangeDataColumnInTestActionData < ActiveRecord::Migration
  def change
    change_column :test_action_data, :data, :text, :limit => 64.kilobytes - 1
  end
end
