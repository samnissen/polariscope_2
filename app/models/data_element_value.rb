class DataElementValue < ActiveRecord::Base
  belongs_to :environment
  belongs_to :data_element
  belongs_to :user

  validates :data_element, presence: true
  validates :environment, presence: true
  validates :value, presence: true

  validate :unique_varname_and_env

  # One Data Element per each
  # Environment and variable name (Data Element)
  def unique_varname_and_env
    if DataElementValue.where(data_element: self.data_element).where(environment: self.environment).any?
      errors.add(:base, "Only one value per environment and variable name allowed.")
    end
  end
end
