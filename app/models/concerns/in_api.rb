module InApi
  extend ActiveSupport::Concern

  included do
    default_scope { where(:archived => false) }
  end

  # http://stackoverflow.com/questions/14482827/scope-for-multiple-models
end
