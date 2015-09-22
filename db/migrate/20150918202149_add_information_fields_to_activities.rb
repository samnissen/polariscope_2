class AddInformationFieldsToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :grouping, :string
    add_column :activities, :object_required, :boolean
    add_column :activities, :data_required, :boolean
  end
end
