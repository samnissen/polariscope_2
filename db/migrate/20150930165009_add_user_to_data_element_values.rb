class AddUserToDataElementValues < ActiveRecord::Migration
  def change
    add_reference :data_element_values, :user, index: true
  end
end
