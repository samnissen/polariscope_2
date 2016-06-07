class DataElementValue < ActiveRecord::Base
  belongs_to :environment
  belongs_to :data_element
  belongs_to :user

  validates :data_element, presence: true
  validates :environment, presence: true
  validates :random_value_length, :inclusion => 1..256, :allow_nil => true

  validate :value_or_random
  validate :unique_varname_and_env

  attr_encrypted :value, random_iv: true

  after_save :destroy_value_if_random

  # One Data Element per each
  # Environment and variable name (Data Element)
  def unique_varname_and_env
    shared_values = DataElementValue.where(data_element: self.data_element).where(environment: self.environment)

    shared_values.each do |sv|
      errors.add(:base, "Only one value per environment and variable name allowed.") unless sv.id == self.id
    end
  end

  # Each Data Element Variable must have either
  # a Value or a Random Value
  def value_or_random
    return true if ( !value.blank? || random_value )

    errors.add(:base, "Please either provide a value or select 'random'.")
  end
  # But it cannot have both
  def destroy_value_if_random
    update_column(:encrypted_value, nil) if random_value
  end
end
