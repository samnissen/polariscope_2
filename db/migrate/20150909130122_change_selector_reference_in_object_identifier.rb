class ChangeSelectorReferenceInObjectIdentifier < ActiveRecord::Migration
  def change
    change_column :object_identifiers, :selector_id, :integer, references: :selectors
  end
end
