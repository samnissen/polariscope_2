class AddUserToScheduledTests < ActiveRecord::Migration
  def change
    add_reference :scheduled_tests, :user, index: true
  end
end
