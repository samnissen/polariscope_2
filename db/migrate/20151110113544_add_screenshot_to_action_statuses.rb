class AddScreenshotToActionStatuses < ActiveRecord::Migration
  def change
    add_column :action_statuses, :screenshot, :text, :limit => 4.gigabytes - 1
  end
end
