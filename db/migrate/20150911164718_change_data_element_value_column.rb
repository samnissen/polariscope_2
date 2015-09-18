class ChangeDataElementValueColumn < ActiveRecord::Migration
  def change
    remove_column :data_elements, :value
    add_column :data_elements, :data_element_value_id, :integer, references: :data_element_values
  end
end
