class ObjectType < ActiveRecord::Base
  include InApi

  def humanized_type_name
    self.type_name.humanize.downcase
  end
end
