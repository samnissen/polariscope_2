class CreateObjectIdentifierSiblings < ActiveRecord::Migration
  def change
    create_table :object_identifier_siblings do |t|
      t.string :identifier
      t.string :id_type
      t.string :selector
      t.references :object_identifier, index: true
      t.references :sibling_relationship, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
