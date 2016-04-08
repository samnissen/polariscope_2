module CarouselHelper
	def run_browser_id(test_status_id)
		teststatus = TestStatus.find(test_status_id)
		browserId = teststatus.browser_type_id
	end

	def browser_icon(test_status_id)
    	browserid = run_browser_id(test_status_id)
    	browser = BrowserType.find(browserid)
    	browser_name = browser.name
    	if /firefox/.match(browser_name)
      		iconfile = "firefox-16.png"
      	elsif /chrome/.match(browser_name)
      		iconfile = "google-chrome.png"
    	else
      		iconfile = ""
    	end
  	end
end