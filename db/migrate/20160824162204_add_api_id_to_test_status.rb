class AddApiIdToTestStatus < ActiveRecord::Migration
  def change
    add_index :test_statuses, :api_id, unique: true
  end
end
