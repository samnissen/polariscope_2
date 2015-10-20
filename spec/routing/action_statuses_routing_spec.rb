require "rails_helper"

RSpec.describe ActionStatusesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/action_statuses").to route_to("action_statuses#index")
    end

    it "routes to #new" do
      expect(:get => "/action_statuses/new").to route_to("action_statuses#new")
    end

    it "routes to #show" do
      expect(:get => "/action_statuses/1").to route_to("action_statuses#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/action_statuses/1/edit").to route_to("action_statuses#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/action_statuses").to route_to("action_statuses#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/action_statuses/1").to route_to("action_statuses#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/action_statuses/1").to route_to("action_statuses#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/action_statuses/1").to route_to("action_statuses#destroy", :id => "1")
    end

  end
end
