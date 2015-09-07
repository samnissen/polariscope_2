class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.references :user, index: true
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
