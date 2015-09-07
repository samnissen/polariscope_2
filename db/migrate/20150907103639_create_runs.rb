class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.string :name
      t.string :description
      t.references :collection, index: true

      t.timestamps
    end
  end
end
