module TestStatusesHelper
  def print_test_success(ts)
    case
    when ts.success.class == TrueClass
      "<span class='passed-status'>Passed</span>".html_safe
    when ts.success.class == FalseClass
      "<span class='failed-status'>Failed</span>".html_safe
    else
      "<span class='pending-status'>Pending</span>".html_safe
    end
  end
end
