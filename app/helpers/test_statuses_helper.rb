module TestStatusesHelper
  def print_test_success(ts)
    case ts.success.class
    when TrueClass
      "<span class='passed-status'>Passed</span>".html_safe
    when FalseClass
      "<span class='failed-status'>Failed</span>".html_safe
    else
      "<span class='pending-status'>Pending</span>".html_safe
    end
  end
end
