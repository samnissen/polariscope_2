class RemoveDataElementValueIdFromDataElements < ActiveRecord::Migration
  def change
    remove_column :data_elements, :data_element_value_id, :integer
  end
end
