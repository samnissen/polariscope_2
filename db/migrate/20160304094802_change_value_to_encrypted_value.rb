class ChangeValueToEncryptedValue < ActiveRecord::Migration
  def change
    rename_column :data_element_values, :value, :encrypted_value
  end
end
