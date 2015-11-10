class RemoveAttachmentFromActionStatuses < ActiveRecord::Migration
  def change
    remove_attachment :action_statuses, :screenshot
  end
end
