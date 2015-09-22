class RemoveAdditionalInfoFromRunTestActions < ActiveRecord::Migration
  def change
    remove_column :run_test_actions, :additional_info, :string
  end
end
