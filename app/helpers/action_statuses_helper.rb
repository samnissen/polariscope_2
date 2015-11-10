module ActionStatusesHelper
  def print_action_success(as)
    puts "as.success.class is #{as.success.class} because as is #{as.inspect}"
    case
    when as.success.class == TrueClass
      "<span class='passed-status'>Passed</span>".html_safe
    when as.success.class == FalseClass
      "<span class='failed-status'>Failed</span>".html_safe
    else
      "<span class='pending-status'>Pending</span>".html_safe
    end
  end
end
