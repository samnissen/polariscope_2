class AddApiResultsToActionStatuses < ActiveRecord::Migration
  def change
    add_column :action_statuses, :api_id, :integer
    add_attachment :action_statuses, :screenshot
  end
end
