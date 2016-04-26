class CreateScheduledTests < ActiveRecord::Migration
  def change
    create_table :scheduled_tests do |t|
      t.text :notes
      t.belongs_to :collection, index: true
      t.string :test_ids
      t.string :next_test
      t.integer :recurring

      t.timestamps
    end
  end
end
