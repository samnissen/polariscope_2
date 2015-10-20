class RenameTestActionDataIdInRunTestActionDatum < ActiveRecord::Migration
  def change
    rename_column :run_test_action_data, :test_action_data_id, :test_action_datum_id
  end
end
