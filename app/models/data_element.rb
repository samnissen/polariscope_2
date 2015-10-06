class DataElement < ActiveRecord::Base
  validates_uniqueness_of :key

  belongs_to :environment
  belongs_to :user

  has_many :data_element_values, :dependent => :destroy
end
