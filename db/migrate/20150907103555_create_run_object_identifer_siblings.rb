class CreateRunObjectIdentiferSiblings < ActiveRecord::Migration
  def change
    create_table :run_object_identifer_siblings do |t|
      t.string :identifier
      t.string :id_type
      t.string :selector
      t.references :run_object_identifer, index: true
      t.references :sibling_relationship, index: true

      t.timestamps
    end
  end
end
