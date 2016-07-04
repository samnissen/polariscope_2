class Collection < ActiveRecord::Base
  belongs_to :user
  validates :name, length: { in: 5..255 }

  has_many :runs
  has_many :testsets, dependent: :destroy

  def alphasort_testset
  	testsets.order('name ASC');
  end

end
