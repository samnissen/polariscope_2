require "rails_helper"

RSpec.describe TestStatusesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/test_statuses").to route_to("test_statuses#index")
    end

    it "routes to #new" do
      expect(:get => "/test_statuses/new").to route_to("test_statuses#new")
    end

    it "routes to #show" do
      expect(:get => "/test_statuses/1").to route_to("test_statuses#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/test_statuses/1/edit").to route_to("test_statuses#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/test_statuses").to route_to("test_statuses#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/test_statuses/1").to route_to("test_statuses#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/test_statuses/1").to route_to("test_statuses#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/test_statuses/1").to route_to("test_statuses#destroy", :id => "1")
    end

  end
end
