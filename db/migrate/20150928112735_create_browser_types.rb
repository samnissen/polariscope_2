class CreateBrowserTypes < ActiveRecord::Migration
  def change
    create_table :browser_types do |t|
      t.string :name
      t.string :key

      t.timestamps
    end
  end
end
