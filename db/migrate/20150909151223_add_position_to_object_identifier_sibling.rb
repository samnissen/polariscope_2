class AddPositionToObjectIdentifierSibling < ActiveRecord::Migration
  def change
    add_column :object_identifier_siblings, :position, :integer
  end
end
