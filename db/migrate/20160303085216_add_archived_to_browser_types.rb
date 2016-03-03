class AddArchivedToBrowserTypes < ActiveRecord::Migration
  def change
    add_column :browser_types, :archived, :boolean
  end
end
