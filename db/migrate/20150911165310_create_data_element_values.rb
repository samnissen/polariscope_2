class CreateDataElementValues < ActiveRecord::Migration
  def change
    create_table :data_element_values do |t|
      t.string :value
      t.belongs_to :enviromnent, index: true

      t.timestamps
    end
  end
end
