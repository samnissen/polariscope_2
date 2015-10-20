class AddSendingBooleansToRuns < ActiveRecord::Migration
  def change
    add_column :runs, :ready_to_send, :boolean, :default => false
    add_column :runs, :sent, :boolean, :default => false
  end
end
