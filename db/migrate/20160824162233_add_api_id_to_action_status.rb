class AddApiIdToActionStatus < ActiveRecord::Migration
  def change
    add_index :action_statuses, :api_id, unique: true
  end
end
