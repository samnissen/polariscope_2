class CreateRunTests < ActiveRecord::Migration
  def change
    create_table :run_tests do |t|
      t.string :name
      t.string :description
      t.belongs_to :user
      t.belongs_to :run

      t.timestamps
    end
  end
end
