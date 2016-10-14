require 'rails_helper'

RSpec.describe "DidYouMeanTypes", type: :request do
  describe "GET /did_you_mean_types" do
    it "works! (now write some real specs)" do
      get did_you_mean_types_path
      expect(response).to have_http_status(200)
    end
  end
end
