class AddEnvironmentToScheduledTests < ActiveRecord::Migration
  def change
    add_reference :scheduled_tests, :environment, index: true
  end
end
