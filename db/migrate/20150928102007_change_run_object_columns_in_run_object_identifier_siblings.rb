class ChangeRunObjectColumnsInRunObjectIdentifierSiblings < ActiveRecord::Migration
  def change
    remove_column :run_object_identifier_siblings, :id_type
    remove_column :run_object_identifier_siblings, :selector

    add_reference :run_object_identifier_siblings, :object_type, index: true
    add_reference :run_object_identifier_siblings, :selector, index: true
  end
end
