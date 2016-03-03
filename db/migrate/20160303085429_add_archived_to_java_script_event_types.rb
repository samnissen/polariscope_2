class AddArchivedToJavaScriptEventTypes < ActiveRecord::Migration
  def change
    add_column :java_script_event_types, :archived, :boolean
  end
end
