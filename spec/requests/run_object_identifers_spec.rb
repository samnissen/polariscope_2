require 'rails_helper'

RSpec.describe "RunObjectIdentifers", type: :request do
  describe "GET /run_object_identifers" do
    it "works! (now write some real specs)" do
      get run_object_identifers_path
      expect(response).to have_http_status(200)
    end
  end
end
