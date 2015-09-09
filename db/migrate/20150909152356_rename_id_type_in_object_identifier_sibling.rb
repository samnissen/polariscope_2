class RenameIdTypeInObjectIdentifierSibling < ActiveRecord::Migration
  def change
    rename_column :object_identifier_siblings, :id_type, :object_type_id
    change_column :object_identifier_siblings, :object_type_id, :integer, references: :object_types
  end
end
