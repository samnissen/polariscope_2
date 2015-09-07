class CreateSiblingRelationships < ActiveRecord::Migration
  def change
    create_table :sibling_relationships do |t|
      t.string :relation

      t.timestamps
    end
  end
end
