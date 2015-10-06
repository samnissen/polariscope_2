class TestActionDatum < ActiveRecord::Base
  belongs_to :object_identifier
  belongs_to :data_element

  acts_as_list scope: :object_identifier

  before_save :swap_variable_and_static

  validate :data_or_variable

  # Each Test Action Data can use either
  # a variable from the User's data elements or
  # a string of static data, but
  # never both. If one is saved it should wipe out the other
  # to clarify the user's intent to both the app
  # and to the user.
  # If the user updated both, default to text string.
  def swap_variable_and_static
    # http://stackoverflow.com/questions/2942162/rails-attribute-changed
    data_added = self.data_changed?
    variable_added = self.data_element_id_changed?

    return true unless (data_added || variable_added)

    case
    when data_added
      self.data_element_id = nil
      return true
    when variable_added
      self.data = nil
      return true
    end
  end

  # Each piece of data must either:
  # - Point to a variable (a DataElement) or
  # - Contain a bit of text.
  def data_or_variable
    yes_data = self.data && !self.data.blank?
    yes_element = self.data_element

    unless yes_data || yes_element
      errors.add(:base, "Please provide data or a variable.")
    end
  end
end
