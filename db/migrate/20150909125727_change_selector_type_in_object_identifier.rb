class ChangeSelectorTypeInObjectIdentifier < ActiveRecord::Migration
  def change
    rename_column :object_identifiers, :selector, :selector_id
    change_column :object_identifiers, :selector_id, :integer, references: :users
  end
end
