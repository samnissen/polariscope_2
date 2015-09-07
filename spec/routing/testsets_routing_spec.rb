require "rails_helper"

RSpec.describe TestsetsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/testsets").to route_to("testsets#index")
    end

    it "routes to #new" do
      expect(:get => "/testsets/new").to route_to("testsets#new")
    end

    it "routes to #show" do
      expect(:get => "/testsets/1").to route_to("testsets#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/testsets/1/edit").to route_to("testsets#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/testsets").to route_to("testsets#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/testsets/1").to route_to("testsets#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/testsets/1").to route_to("testsets#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/testsets/1").to route_to("testsets#destroy", :id => "1")
    end

  end
end
