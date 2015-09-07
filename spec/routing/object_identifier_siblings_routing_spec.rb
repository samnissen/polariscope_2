require "rails_helper"

RSpec.describe ObjectIdentifierSiblingsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/object_identifier_siblings").to route_to("object_identifier_siblings#index")
    end

    it "routes to #new" do
      expect(:get => "/object_identifier_siblings/new").to route_to("object_identifier_siblings#new")
    end

    it "routes to #show" do
      expect(:get => "/object_identifier_siblings/1").to route_to("object_identifier_siblings#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/object_identifier_siblings/1/edit").to route_to("object_identifier_siblings#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/object_identifier_siblings").to route_to("object_identifier_siblings#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/object_identifier_siblings/1").to route_to("object_identifier_siblings#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/object_identifier_siblings/1").to route_to("object_identifier_siblings#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/object_identifier_siblings/1").to route_to("object_identifier_siblings#destroy", :id => "1")
    end

  end
end
