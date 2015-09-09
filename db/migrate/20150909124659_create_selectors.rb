class CreateSelectors < ActiveRecord::Migration
  def change
    create_table :selectors do |t|
      t.string :selector_name

      t.timestamps
    end
  end
end
