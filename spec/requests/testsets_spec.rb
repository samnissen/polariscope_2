require 'rails_helper'

RSpec.describe "Testsets", type: :request do
  describe "GET /testsets" do
    it "works! (now write some real specs)" do
      get testsets_path
      expect(response).to have_http_status(200)
    end
  end
end
