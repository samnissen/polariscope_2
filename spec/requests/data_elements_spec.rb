require 'rails_helper'

RSpec.describe "DataElements", type: :request do
  describe "GET /data_elements" do
    it "works! (now write some real specs)" do
      get data_elements_path
      expect(response).to have_http_status(200)
    end
  end
end
