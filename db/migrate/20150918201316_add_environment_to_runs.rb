class AddEnvironmentToRuns < ActiveRecord::Migration
  def change
    add_reference :runs, :environment, index: true
  end
end
