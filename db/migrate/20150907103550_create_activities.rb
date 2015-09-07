class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :action_name

      t.timestamps
    end
  end
end
