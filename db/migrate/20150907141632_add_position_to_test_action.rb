class AddPositionToTestAction < ActiveRecord::Migration
  def change
    add_column :test_actions, :position, :integer
  end
end
