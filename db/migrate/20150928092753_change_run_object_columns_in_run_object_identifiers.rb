class ChangeRunObjectColumnsInRunObjectIdentifiers < ActiveRecord::Migration
  def change
    remove_column :run_object_identifiers, :id_type
    remove_column :run_object_identifiers, :selector

    add_reference :run_object_identifiers, :object_type, index: true
    add_reference :run_object_identifiers, :selector, index: true
  end
end
