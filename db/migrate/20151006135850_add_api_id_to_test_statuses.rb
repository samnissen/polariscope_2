class AddApiIdToTestStatuses < ActiveRecord::Migration
  def change
    add_column :test_statuses, :api_id, :integer
  end
end
