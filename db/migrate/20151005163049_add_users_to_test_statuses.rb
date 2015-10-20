class AddUsersToTestStatuses < ActiveRecord::Migration
  def change
    add_reference :test_statuses, :user, index: true
  end
end
