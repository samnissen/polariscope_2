class CreateTestStatuses < ActiveRecord::Migration
  def change
    create_table :test_statuses do |t|
      t.belongs_to :run_test, index: true
      t.belongs_to :browser_type, index: true
      t.boolean :success
      t.string :notes
      t.text :log, :limit => 64.kilobytes + 1
      # http://stackoverflow.com/a/19389681/1651458

      t.timestamps
    end
  end
end
