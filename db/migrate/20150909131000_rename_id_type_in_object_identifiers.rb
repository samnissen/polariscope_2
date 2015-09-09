class RenameIdTypeInObjectIdentifiers < ActiveRecord::Migration
  def change
    rename_column :object_identifiers, :id_type, :object_type_id
    change_column :object_identifiers, :object_type_id, :integer, references: :object_types
  end
end
