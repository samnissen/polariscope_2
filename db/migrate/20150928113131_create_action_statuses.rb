class CreateActionStatuses < ActiveRecord::Migration
  def change
    create_table :action_statuses do |t|
      t.belongs_to :run_test_action, index: true
      t.belongs_to :browser_type, index: true
      t.boolean :success
      t.string :notes
      t.text :log, :limit => 64.kilobytes + 1

      t.timestamps
    end
  end
end
