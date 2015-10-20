require 'rails_helper'

RSpec.describe "TestStatuses", type: :request do
  describe "GET /test_statuses" do
    it "works! (now write some real specs)" do
      get test_statuses_path
      expect(response).to have_http_status(200)
    end
  end
end
