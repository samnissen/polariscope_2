require "rails_helper"

RSpec.describe ObjectIdentifiersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/object_identifiers").to route_to("object_identifiers#index")
    end

    it "routes to #new" do
      expect(:get => "/object_identifiers/new").to route_to("object_identifiers#new")
    end

    it "routes to #show" do
      expect(:get => "/object_identifiers/1").to route_to("object_identifiers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/object_identifiers/1/edit").to route_to("object_identifiers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/object_identifiers").to route_to("object_identifiers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/object_identifiers/1").to route_to("object_identifiers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/object_identifiers/1").to route_to("object_identifiers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/object_identifiers/1").to route_to("object_identifiers#destroy", :id => "1")
    end

  end
end
