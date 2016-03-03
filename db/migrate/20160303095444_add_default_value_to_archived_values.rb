class AddDefaultValueToArchivedValues < ActiveRecord::Migration
  def change
    change_column :java_script_event_types, :archived, :boolean, :default => false
    change_column :browser_types, :archived, :boolean, :default => false
    change_column :object_types, :archived, :boolean, :default => false
    change_column :selectors, :archived, :boolean, :default => false
    change_column :sibling_relationships, :archived, :boolean, :default => false
    change_column :activities, :archived, :boolean, :default => false
  end
end
