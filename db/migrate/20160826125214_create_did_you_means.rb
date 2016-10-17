class CreateDidYouMeans < ActiveRecord::Migration
  def change
    create_table :did_you_means do |t|
      t.belongs_to :action_status, index: true
      t.string :possibility
      t.belongs_to :did_you_mean_type, index: true

      t.timestamps
    end
  end
end
