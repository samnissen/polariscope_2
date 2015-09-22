class RemoveAdditionalInfoFromTestActions < ActiveRecord::Migration
  def change
    remove_column :test_actions, :additional_info, :string
  end
end
