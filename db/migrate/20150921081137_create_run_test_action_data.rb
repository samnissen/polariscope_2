class CreateRunTestActionData < ActiveRecord::Migration
  def change
    create_table :run_test_action_data do |t|
      t.string :data
      t.belongs_to :run_object_identifier, index: true

      t.timestamps
    end
  end
end
