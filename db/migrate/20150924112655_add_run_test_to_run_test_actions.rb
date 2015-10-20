class AddRunTestToRunTestActions < ActiveRecord::Migration
  def change
    add_reference :run_test_actions, :run_test, index: true
  end
end
