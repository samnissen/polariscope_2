class AddRandomValueLengthToDataElementValues < ActiveRecord::Migration
  def change
    add_column :data_element_values, :random_value_length, :integer, default: 8
  end
end
