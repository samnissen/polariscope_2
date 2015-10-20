class AddUsersToActionStatuses < ActiveRecord::Migration
  def change
    add_reference :action_statuses, :user, index: true
  end
end
