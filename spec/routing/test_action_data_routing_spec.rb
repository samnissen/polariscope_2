require "rails_helper"

RSpec.describe TestActionDataController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/test_action_data").to route_to("test_action_data#index")
    end

    it "routes to #new" do
      expect(:get => "/test_action_data/new").to route_to("test_action_data#new")
    end

    it "routes to #show" do
      expect(:get => "/test_action_data/1").to route_to("test_action_data#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/test_action_data/1/edit").to route_to("test_action_data#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/test_action_data").to route_to("test_action_data#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/test_action_data/1").to route_to("test_action_data#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/test_action_data/1").to route_to("test_action_data#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/test_action_data/1").to route_to("test_action_data#destroy", :id => "1")
    end

  end
end
