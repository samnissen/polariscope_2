class Activity < ActiveRecord::Base
  include InApi

  def collection_display_name
    case "#{self.action_name}"
    when "jsinlineevent"
      "JavaScript inline event: #{self.description}"
    else
      "#{self.action_name}".humanize.capitalize + ": #{self.description}"
    end
  end

  # Override boolean when the data required
  # is a JavaScript inline event (like 'onclick')
  # To provide a better UX with a dropdown for event types
  def data_required
    return false if self.action_name == 'jsinlineevent'
    super
  end
end
