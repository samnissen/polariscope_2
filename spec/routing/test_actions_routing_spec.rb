require "rails_helper"

RSpec.describe TestActionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/test_actions").to route_to("test_actions#index")
    end

    it "routes to #new" do
      expect(:get => "/test_actions/new").to route_to("test_actions#new")
    end

    it "routes to #show" do
      expect(:get => "/test_actions/1").to route_to("test_actions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/test_actions/1/edit").to route_to("test_actions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/test_actions").to route_to("test_actions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/test_actions/1").to route_to("test_actions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/test_actions/1").to route_to("test_actions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/test_actions/1").to route_to("test_actions#destroy", :id => "1")
    end

  end
end
