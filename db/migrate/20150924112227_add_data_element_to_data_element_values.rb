class AddDataElementToDataElementValues < ActiveRecord::Migration
  def change
    add_reference :data_element_values, :data_element, index: true
  end
end
