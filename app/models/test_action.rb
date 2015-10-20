class TestAction < ActiveRecord::Base
  belongs_to :testset
  belongs_to :activity
  belongs_to :user

  has_one :object_identifier, dependent: :destroy
  # has_one :test_action_datum, dependent: :destroy

  acts_as_list scope: :testset

  validates :activity, presence: true, unless: :pointer
  validates :testset, presence: true
  validates :name, length: { in: 5..255 }, unless: :pointer
  validate :pointer_points_to_testset
  validate :prevent_infinite_poiting

  before_save :clear_pointer_data
  before_save :manage_identifiers

  # Actions that require data, but no object
  # need a sort of blank object created in their place
  # However if a user changes the action, that blank object
  # might need to be removed, and its data transferred.
  def manage_identifiers
    obj = self.activity.object_required
    data = self.activity.data_required

    create_update_null_identifier if !obj && data
  end

  def create_update_null_identifier
    null_object = ObjectType.where(type_name: "n/a").first
    null_selector = Selector.where(selector_name: "n/a").first
    params = {
      identifier: "null",
      object_type: null_object,
      selector: null_selector,
      test_action: self
    }

    if self.object_identifier
      self.object_identifier.update(params)
    else
      self.build_object_identifier(params)
    end
  end

  # A pointer must point to an actual testset
  def pointer_points_to_testset
    return true unless self.pointer

    return true if Testset.where(id: self.pointer).any?

    errors.add(:base, "Your pointed to Test #{self.pointer} could not be found.")
  end

  # If the user wants to create a pointer
  # we should disallow them to add any other data
  def clear_pointer_data
    return true unless self.pointer

    self.name = nil
    self.description = nil
    self.activity = nil
  end

  # The pointer cannot point to the testset
  # which contains this test_action.
  def prevent_infinite_poiting
    return true unless self.pointer

    return true unless Testset.where(id: self.pointer).first == self.testset

    errors.add(:base, "Pointing to yourself could create an infinite loop (and break the space-time continuum).")
  end
end
