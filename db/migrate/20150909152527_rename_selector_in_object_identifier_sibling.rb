class RenameSelectorInObjectIdentifierSibling < ActiveRecord::Migration
  def change
    rename_column :object_identifier_siblings, :selector, :selector_id
    change_column :object_identifier_siblings, :selector_id, :integer, references: :selectors
  end
end
