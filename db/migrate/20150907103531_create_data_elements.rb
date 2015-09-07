class CreateDataElements < ActiveRecord::Migration
  def change
    create_table :data_elements do |t|
      t.string :key
      t.string :value
      t.references :environment, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
