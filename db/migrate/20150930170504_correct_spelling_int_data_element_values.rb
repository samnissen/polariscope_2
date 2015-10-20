class CorrectSpellingIntDataElementValues < ActiveRecord::Migration
  def change
    rename_column :data_element_values, :enviromnent_id, :environment_id
  end
end
