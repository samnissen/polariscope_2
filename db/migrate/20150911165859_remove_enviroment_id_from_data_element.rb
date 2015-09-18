class RemoveEnviromentIdFromDataElement < ActiveRecord::Migration
  def change
    remove_column :data_elements, :environment_id, :integer
  end
end
