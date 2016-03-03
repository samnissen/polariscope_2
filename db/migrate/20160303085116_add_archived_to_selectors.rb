class AddArchivedToSelectors < ActiveRecord::Migration
  def change
    add_column :selectors, :archived, :boolean
  end
end
