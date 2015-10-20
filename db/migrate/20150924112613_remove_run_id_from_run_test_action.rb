class RemoveRunIdFromRunTestAction < ActiveRecord::Migration
  def change
    remove_column :run_test_actions, :run_id, :integer
  end
end
