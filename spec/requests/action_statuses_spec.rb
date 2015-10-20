require 'rails_helper'

RSpec.describe "ActionStatuses", type: :request do
  describe "GET /action_statuses" do
    it "works! (now write some real specs)" do
      get action_statuses_path
      expect(response).to have_http_status(200)
    end
  end
end
