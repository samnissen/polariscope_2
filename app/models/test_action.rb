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
  validate :prevent_infinite_pointing
  validate :prevent_points_to_self

  before_save :clear_pointer_data
  before_save :manage_identifiers

  # Actions that require data, but no object
  # need a sort of blank object created in their place
  # However if a user changes the action, that blank object
  # might need to be removed, and its data transferred.
  def manage_identifiers
    return true if self.pointer

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
    return false
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
  def prevent_points_to_self
    return true unless self.pointer
    point_to_self = Testset.where(id: self.pointer).first == self.testset
    return true unless point_to_self

    errors.add(:base, "Pointing to yourself could break the space-time continuum.")
  end

  def prevent_infinite_pointing
    return true unless Testset.where(id: self.pointer).first
    return true unless Testset.where(id: self.pointer).first.test_actions.size > 0

    pointing_loop = Testset.where(id: self.pointer).first.test_actions.map { |ta|
      # Given two testsets,
      # where one action in TS1 points to TS2
      # and one action in TS2 points back to TS1
      cross_pointing = (ta.pointer == self.testset.id)

      # Given three testsets
      # where one action in TS1 points to TS2
      # and where one action in TS2 points to TS3
      # and where one action in TS3 points to TS1
      ts3 = Testset.where(id: ta.pointer).first
      if ta.pointer && ts3 && ts3.test_actions.size > 0
        loop_pointing = ts3.test_actions.map { |sta|
          true if (sta.pointer == self.testset.id)
        }.compact.first
      end

      true if (cross_pointing || loop_pointing)
    }.compact.first

    return true unless pointing_loop
    errors.add(:base, "Pointing in an infinite loop could break the space-time continuum.")
  end

  def testset_grouping
    self.testset
  end

  def self.duplicate_action(old_test_action, current_user, existing_testset)
    new_test_action = old_test_action.dup
    new_test_action.testset  = existing_testset
    new_test_action.user     = current_user
    new_test_action.save!

    if old_test_action.object_identifier
      new_test_action.object_identifier = ObjectIdentifier.create({
        identifier: old_test_action.object_identifier.identifier,
        object_type_id: old_test_action.object_identifier.object_type_id,
        selector_id: old_test_action.object_identifier.selector_id,
        test_action_id: new_test_action.id,
        user_id: current_user.id
      })

      old_test_action.object_identifier.object_identifier_siblings.each do |sib|
        new_attributes = {
          :user_id => current_user.id,
          :object_identifier => new_test_action.object_identifier
        }
        ObjectIdentifierSibling.new(sib.dup.attributes.merge(new_attributes)).save!
      end

      old_test_action.object_identifier.test_action_data.each do |datum|
        newd = datum.dup
        newd.object_identifier = new_test_action.object_identifier
        new_test_action.object_identifier.test_action_data << newd

        if datum.data_element && (current_user.id != datum.data_element.user_id)
          # Create environment if none exists
          env = Environment.where(user: current_user).last || Environment.create(user: current_user, name: "Auto-created when test step copied")
          # Copy data_element
          dataelement = DataElement.new(datum.data_element.attributes.except('id'))
          dataelement.user_id = current_user.id
          dataelement.save!
          # Replace Test Action Data's Data Element
          newd.data_element = dataelement
          newd.save!
          # Create blank data element
          dataelementvalue = DataElementValue.create(data_element: dataelement, environment: env, user: current_user, value: "Overwrite me with some actual data.")
        end
      end
    end

    unless new_test_action.save
      new_test_action.object_identifier.errors.full_messages.each do |msg|
        new_test_action.errors.add(:base, "Object Identifier: #{msg}")
      end
      new_test_action.object_identifier.object_identifier_siblings.each do |s|
        s.errors.full_messages.each{|msg| new_test_action.errors.add(:base, "Object Identifier Sibling: #{msg}") }
      end
      new_test_action.object_identifier.test_action_data.each do |d|
        d.errors.full_messages.each{|msg| new_test_action.errors.add(:base, "Test Action Datum: #{msg}") }
      end
    end

    return new_test_action
  end
end
