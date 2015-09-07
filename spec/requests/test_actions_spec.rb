require 'rails_helper'

RSpec.describe "TestActions", type: :request do
  describe "GET /test_actions" do
    it "works! (now write some real specs)" do
      get test_actions_path
      expect(response).to have_http_status(200)
    end
  end
end
