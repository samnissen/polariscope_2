class BrowserType < ActiveRecord::Base
  validates :key, uniqueness: true
end
