class CreateDidYouMeanTypes < ActiveRecord::Migration
  def change
    create_table :did_you_mean_types do |t|
      t.string :description
      t.string :key
      t.boolean :archived

      t.timestamps
    end
  end
end
