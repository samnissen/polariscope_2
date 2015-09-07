class CreateEnvironments < ActiveRecord::Migration
  def change
    create_table :environments do |t|
      t.string :name
      t.references :user, index: true

      t.timestamps
    end
  end
end
