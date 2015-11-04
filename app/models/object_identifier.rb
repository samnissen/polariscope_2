class ObjectIdentifier < ActiveRecord::Base
  belongs_to :test_action
  acts_as_list scope: :test_action
  belongs_to :user

  has_many :object_identifier_siblings, -> { order(position: :asc) }, dependent: :destroy

  has_many :test_action_data, -> { order(position: :asc) }, dependent: :destroy

  belongs_to :object_type
  belongs_to :selector

  validates :object_type_id, presence: true
  validates :selector_id, presence: true
  validates :test_action_id, presence: true

  def is_event?
    false unless self.test_action && self.test_action.activity
    self.test_action.activity.action_name == "jsinlineevent"
  end

  def event_type
    nil unless self.is_event?
    self.test_action_data.each do |datum|
      return datum.data if JavaScriptEventType.where(name: "#{datum.data}").any?
    end
    nil
  end

  def event_type=(e = '')
    return nil unless self.is_event? && e

    if JavaScriptEventType.where(name: e).any?
      tad = self.new_or_existing(e)
      tad.data = e
      tad.save!
    else
      self.errors.add(:base, 'Invalid event type')
    end
  end

  def new_or_existing(e)
    return self.existing if Array(self.existing).any?

    TestActionDatum.new(object_identifier: self)
  end

  def existing
    return self.test_action_data.map { |datum|
      datum if JavaScriptEventType.where(name: "#{datum.data}").first
    }.compact.first
  end
end
