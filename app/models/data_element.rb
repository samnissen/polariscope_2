class DataElement < ActiveRecord::Base
  # validates_uniqueness_of :key

  belongs_to :environment
  belongs_to :user

  has_many :data_element_values, :dependent => :destroy

  validate :unique_key_per_user

  # One Data Element per each
  # Environment and variable name (Data Element)
  def unique_key_per_user
    if DataElement.where(key: self.key).where(user: self.user).any?
      errors.add(:base, "Key must be unique (per user).")
    end
  end
end
