require 'rails_helper'

RSpec.describe "RunObjectIdentiferSiblings", type: :request do
  describe "GET /run_object_identifer_siblings" do
    it "works! (now write some real specs)" do
      get run_object_identifer_siblings_path
      expect(response).to have_http_status(200)
    end
  end
end
