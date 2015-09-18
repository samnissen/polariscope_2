class CreateTestActionData < ActiveRecord::Migration
  def change
    create_table :test_action_data do |t|
      t.string :data
      t.belongs_to :test_action, index: true

      t.timestamps
    end
  end
end
