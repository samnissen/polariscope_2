require 'rails_helper'

RSpec.describe "Environments", type: :request do
  describe "GET /environments" do
    it "works! (now write some real specs)" do
      get environments_path
      expect(response).to have_http_status(200)
    end
  end
end
