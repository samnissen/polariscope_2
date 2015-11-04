class CreateJavaScriptEventTypes < ActiveRecord::Migration
  def change
    create_table :java_script_event_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
