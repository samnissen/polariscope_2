require 'rails_helper'

RSpec.describe "TestActionData", type: :request do
  describe "GET /test_action_data" do
    it "works! (now write some real specs)" do
      get test_action_data_path
      expect(response).to have_http_status(200)
    end
  end
end
