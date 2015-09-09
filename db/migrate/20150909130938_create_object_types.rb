class CreateObjectTypes < ActiveRecord::Migration
  def change
    create_table :object_types do |t|
      t.string :type_name
      t.string :html

      t.timestamps
    end
  end
end
