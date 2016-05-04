class ChangeNextTestInScheduledTest < ActiveRecord::Migration
  def change
    change_column :scheduled_tests, :next_test, :timestamp
  end
end
