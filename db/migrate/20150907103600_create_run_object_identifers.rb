class CreateRunObjectIdentifers < ActiveRecord::Migration
  def change
    create_table :run_object_identifers do |t|
      t.string :identifier
      t.string :id_type
      t.string :selector
      t.references :run_test_action, index: true

      t.timestamps
    end
  end
end
