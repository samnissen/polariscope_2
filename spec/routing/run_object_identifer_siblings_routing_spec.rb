require "rails_helper"

RSpec.describe RunObjectIdentiferSiblingsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/run_object_identifer_siblings").to route_to("run_object_identifer_siblings#index")
    end

    it "routes to #new" do
      expect(:get => "/run_object_identifer_siblings/new").to route_to("run_object_identifer_siblings#new")
    end

    it "routes to #show" do
      expect(:get => "/run_object_identifer_siblings/1").to route_to("run_object_identifer_siblings#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/run_object_identifer_siblings/1/edit").to route_to("run_object_identifer_siblings#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/run_object_identifer_siblings").to route_to("run_object_identifer_siblings#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/run_object_identifer_siblings/1").to route_to("run_object_identifer_siblings#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/run_object_identifer_siblings/1").to route_to("run_object_identifer_siblings#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/run_object_identifer_siblings/1").to route_to("run_object_identifer_siblings#destroy", :id => "1")
    end

  end
end
