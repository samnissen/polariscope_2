class Environment < ActiveRecord::Base
  belongs_to :user

  has_many :data_element_values
end
