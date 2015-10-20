class RenameRunObjectIdentiferIdInRunObjectIdentifierSibling < ActiveRecord::Migration
  def change
    remove_column :run_object_identifier_siblings, :run_object_identifer_id

    add_reference :run_object_identifier_siblings, :run_object_identifier, index: true
  end
end
