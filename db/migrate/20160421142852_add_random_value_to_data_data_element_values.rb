class AddRandomValueToDataDataElementValues < ActiveRecord::Migration
  def change
    add_column :data_element_values, :random_value, :boolean, default: false
  end
end
