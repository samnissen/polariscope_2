module RunsHelper
  def display_browsers(run)
    run.browsers.map { |b|
      matched_browser = BrowserType.where(:key => b).first
      if matched_browser
        "<code>#{html_escape(matched_browser.name)}</code>"
      else
        "<code>#{html_escape(b)}</code>"
      end
    }.join(', ').html_safe
  end

  def display_test_status(run_test)
    return 'No statuses to display' unless run_test.test_statuses

    # run_test	browser_type	success	notes	log
    run_test.test_statuses.map{ |status|
      link_to "#{status.browser_type.name}: #{status_success_display(status.success)}".html_safe,
                  collection_run_run_test_test_status_path(status.run_test.run.collection, status.run_test.run, status.run_test, status),
                  :class => 'btn browser-test-status browser-type-' + "#{status.browser_type.id}"
    }.join(' ').html_safe
  end

  def carousel_playback_button(run_test, rt_id)
    htmlstrings = Array.new
    run_browser_ids(rt_id).each do |browser|
      if run_test.screenshot_count(browser) > 0
        string_success = "<span class=\"carousel-playback-btn\"><button class=\"playback-button\" id=\"#{browser}\" value=\"hide/show\">#{image_tag(browser_icon(browser))}</button></span>"
        htmlstrings << string_success
      else
        string_disable = "<span class=\"carousel-playback-btn disabled\"><button class=\"playback-button\" id=\"hideshow\" value=\"hide/show\"></button></span>".html_safe
        htmlstrings << string_disable
      end
    end
    htmlstrings.join(' ').html_safe
  end

  def display_test_action_status(rta)
    return 'No statuses to display' unless rta.action_statuses

    # run_test actions	browser_type	success	notes	log
    rta.action_statuses.map{ |status|
      link_to "#{status.browser_type.name}: #{status_success_display(status.success)}".html_safe,
                  collection_run_run_test_run_test_action_action_status_path(status.run_test_action.run_test.run.collection, status.run_test_action.run_test.run, status.run_test_action.run_test, status.run_test_action, status),
                  :class => 'btn browser-action-status browser-type-' + "#{status.browser_type.id}"
    }.join(' ').html_safe
  end

  def status_success_display(bool)
    if bool.is_a? TrueClass
      "<span class=\"status-passed\">Passed</span>"
    elsif bool.is_a? FalseClass
      "<span class=\"status-failed\">Failed</span>"
    else
      "<span class=\"status-pending\">Pending</span>"
    end
  end

end
