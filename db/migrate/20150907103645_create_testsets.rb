class CreateTestsets < ActiveRecord::Migration
  def change
    create_table :testsets do |t|
      t.string :name
      t.string :description
      t.references :collection, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
