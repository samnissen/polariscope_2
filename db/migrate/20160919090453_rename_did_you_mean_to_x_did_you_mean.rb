class RenameDidYouMeanToXDidYouMean < ActiveRecord::Migration
  def change
    rename_table :did_you_means, :x_did_you_means
  end
end
