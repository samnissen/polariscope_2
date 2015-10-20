class AddPointerToTestActions < ActiveRecord::Migration
  def change
    add_column :test_actions, :pointer, :integer
  end
end
