class AddBrowsersToRuns < ActiveRecord::Migration
  def change
    add_column :runs, :browsers, :string
  end
end
