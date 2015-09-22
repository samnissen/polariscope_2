require "rails_helper"

RSpec.describe RunTestActionDataController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/run_test_action_data").to route_to("run_test_action_data#index")
    end

    it "routes to #new" do
      expect(:get => "/run_test_action_data/new").to route_to("run_test_action_data#new")
    end

    it "routes to #show" do
      expect(:get => "/run_test_action_data/1").to route_to("run_test_action_data#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/run_test_action_data/1/edit").to route_to("run_test_action_data#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/run_test_action_data").to route_to("run_test_action_data#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/run_test_action_data/1").to route_to("run_test_action_data#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/run_test_action_data/1").to route_to("run_test_action_data#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/run_test_action_data/1").to route_to("run_test_action_data#destroy", :id => "1")
    end

  end
end
