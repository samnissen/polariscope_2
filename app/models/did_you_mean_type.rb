class DidYouMeanType < ActiveRecord::Base
  include InApi

  has_many :x_did_you_means
end
