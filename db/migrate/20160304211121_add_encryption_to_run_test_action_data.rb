class AddEncryptionToRunTestActionData < ActiveRecord::Migration
  def change
    add_column :run_test_action_data, :encrypted, :boolean, default: false
  end
end
