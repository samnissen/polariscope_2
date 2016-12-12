require 'rails_helper'
include ERB::Util # https://github.com/rails/rails/issues/7330

# Specs in this file have access to a helper object that includes
# the RunsHelper. For example:
#
# describe RunsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe RunsHelper, type: :helper do
  context "a run with an archived browser" do
    before(:all) do
      @run = create(:run_with_compile)
      @archived_browser = BrowserType.where(:key => @run.browsers.last).last
      @another_browser = BrowserType.where(:key => @run.browsers.first).last
      @archived_browser.update_attribute(:archived, true)
    end

    it "displays all browsers" do
      browser_displayed = display_browsers(@run)

      expect(browser_displayed).to match(Regexp.new("#{@archived_browser.name}"))
      expect(browser_displayed).to match(Regexp.new("#{@another_browser.name}"))
    end

    it "gets link to all test statuses with name" do
      result = display_test_status(@run.run_tests.first)

      expect(result).to match(Regexp.new("#{@archived_browser.name}"))
      expect(result).to match(Regexp.new("#{@another_browser.name}"))
    end

    it "gets link to all test actions with name"  do
      result = display_test_action_status(@run.run_tests.first.run_test_actions.first)

      expect(result).to match(Regexp.new("#{@archived_browser.name}"))
      expect(result).to match(Regexp.new("#{@another_browser.name}"))
    end
  end
end
