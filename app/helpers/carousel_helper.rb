module CarouselHelper
	def run_browser_ids(run_id)
		browserids = Array.new
		TestStatus.where(run_test_id: run_id).find_each do |ts|
			browserids << ts.browser_type_id
		end
		return browserids
	end

	def browser_icon(browserid)
    	browser = BrowserType.find(browserid)
    	browser_name = browser.name
    	if /firefox/i.match(browser_name)
      		iconfile = "firefox-16.png"
      	elsif /chrome/i.match(browser_name)
      		iconfile = "google-chrome.png"
    	else
      		iconfile = "eagle.jpg"
    	end
    	return iconfile
    end
end		