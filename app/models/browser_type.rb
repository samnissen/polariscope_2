class BrowserType < ActiveRecord::Base
  include InApi

  validates :key, uniqueness: true
end
