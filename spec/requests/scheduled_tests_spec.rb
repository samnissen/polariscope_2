require 'rails_helper'

RSpec.describe "ScheduledTests", type: :request do
  describe "GET /scheduled_tests" do
    it "works! (now write some real specs)" do
      get scheduled_tests_path
      expect(response).to have_http_status(200)
    end
  end
end
