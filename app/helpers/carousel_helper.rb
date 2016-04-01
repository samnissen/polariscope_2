module CarouselHelper
	def run_browser_id(test_status_id)
		teststatus = TestStatus.find(test_status_id)
		browserId = teststatus.browser_type_id
	end
end