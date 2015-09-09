class AddPositionToDataElement < ActiveRecord::Migration
  def change
    add_column :data_elements, :position, :integer
  end
end
