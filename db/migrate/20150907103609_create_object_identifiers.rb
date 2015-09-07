class CreateObjectIdentifiers < ActiveRecord::Migration
  def change
    create_table :object_identifiers do |t|
      t.string :identifier
      t.string :id_type
      t.string :selector
      t.references :test_action, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
