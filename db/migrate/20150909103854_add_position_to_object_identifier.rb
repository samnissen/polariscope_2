class AddPositionToObjectIdentifier < ActiveRecord::Migration
  def change
    add_column :object_identifiers, :position, :integer
  end
end
