class AddArchivedToSiblingRelationships < ActiveRecord::Migration
  def change
    add_column :sibling_relationships, :archived, :boolean
  end
end
