require 'rails_helper'

RSpec.describe "RunTests", type: :request do
  describe "GET /run_tests" do
    it "works! (now write some real specs)" do
      get run_tests_path
      expect(response).to have_http_status(200)
    end
  end
end
