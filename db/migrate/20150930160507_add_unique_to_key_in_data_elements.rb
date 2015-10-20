class AddUniqueToKeyInDataElements < ActiveRecord::Migration
  def change
    change_column :data_elements, :key,  :string, unique: true
  end
end
