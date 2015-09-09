class Testset < ActiveRecord::Base
  belongs_to :collection
  belongs_to :user

  validates :name, length: { in: 5..255 }

  validates :collection, presence: true

  has_many :test_actions, -> { order(position: :asc) }
end
