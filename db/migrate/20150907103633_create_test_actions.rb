class CreateTestActions < ActiveRecord::Migration
  def change
    create_table :test_actions do |t|
      t.string :name
      t.string :description
      t.references :testset, index: true
      t.references :activity, index: true
      t.string :additional_info
      t.references :user, index: true

      t.timestamps
    end
  end
end
