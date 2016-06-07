class AddBrowsersToScheduledTests < ActiveRecord::Migration
  def change
    add_column :scheduled_tests, :browser_ids, :string
  end
end
