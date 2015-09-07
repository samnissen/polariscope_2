require 'rails_helper'

RSpec.describe "RunTestActions", type: :request do
  describe "GET /run_test_actions" do
    it "works! (now write some real specs)" do
      get run_test_actions_path
      expect(response).to have_http_status(200)
    end
  end
end
