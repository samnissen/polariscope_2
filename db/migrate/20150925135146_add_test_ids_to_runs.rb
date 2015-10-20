class AddTestIdsToRuns < ActiveRecord::Migration
  def change
    add_column :runs, :test_ids, :string
  end
end
