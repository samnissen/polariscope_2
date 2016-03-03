class AddArchivedToObjectTypes < ActiveRecord::Migration
  def change
    add_column :object_types, :archived, :boolean
  end
end
