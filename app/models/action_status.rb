class ActionStatus < ActiveRecord::Base
  belongs_to :run_test_action
  belongs_to :browser_type

  has_attached_file :screenshot
  validates_attachment_content_type :screenshot, content_type: /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, attributes: :screenshot, less_than: 5.megabytes
end
