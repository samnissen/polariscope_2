class DataElement < ActiveRecord::Base
  belongs_to :environment
  belongs_to :user
end
