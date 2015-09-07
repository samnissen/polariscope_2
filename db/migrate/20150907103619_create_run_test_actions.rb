class CreateRunTestActions < ActiveRecord::Migration
  def change
    create_table :run_test_actions do |t|
      t.string :name
      t.string :description
      t.references :test_action, index: true
      t.references :run, index: true
      t.references :activity, index: true
      t.string :additional_info

      t.timestamps
    end
  end
end
