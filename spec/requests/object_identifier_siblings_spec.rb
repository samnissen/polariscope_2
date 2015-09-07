require 'rails_helper'

RSpec.describe "ObjectIdentifierSiblings", type: :request do
  describe "GET /object_identifier_siblings" do
    it "works! (now write some real specs)" do
      get object_identifier_siblings_path
      expect(response).to have_http_status(200)
    end
  end
end
