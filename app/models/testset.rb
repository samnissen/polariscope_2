class Testset < ActiveRecord::Base

  belongs_to :collection
  belongs_to :user

  validates :name, length: { in: 5..255 }

  validates :collection, presence: true

  has_many :test_actions, -> { order(position: :asc) }, dependent: :destroy

  before_destroy :has_pointers
  after_save :sort_test_actions_order

  def sort_test_actions_order
    i = 1
    self.test_actions.each do |ta|
      ta.insert_at(i)
      i += 1
    end
  end

  def has_pointers
    pointers = TestAction.where(pointer: self.id)

    if pointers.any?
      names = TestAction.where(pointer: self.id).map{|ta| "'#{ta.testset.name}'"}.compact.uniq
      if (names.size > 1)
        msg =  "The pointers to this test must be removed before this test can be deleted. "
        msg += "They can be found in the following tests: #{names.join(', ')}"
      else
        msg =  "The pointer to this test must be removed before this test can be deleted. "
        msg += "It can be found in the following test: #{names.first}"
      end
      errors.add(:base, msg)
      return false
    end
  end
end
