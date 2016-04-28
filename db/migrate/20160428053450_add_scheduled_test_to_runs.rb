class AddScheduledTestToRuns < ActiveRecord::Migration
  def change
    add_reference :runs, :scheduled_test, index: true
  end
end
