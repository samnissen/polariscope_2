require "rails_helper"

RSpec.describe RunObjectIdentifiersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/run_object_identifers").to route_to("run_object_identifers#index")
    end

    it "routes to #new" do
      expect(:get => "/run_object_identifers/new").to route_to("run_object_identifers#new")
    end

    it "routes to #show" do
      expect(:get => "/run_object_identifers/1").to route_to("run_object_identifers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/run_object_identifers/1/edit").to route_to("run_object_identifers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/run_object_identifers").to route_to("run_object_identifers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/run_object_identifers/1").to route_to("run_object_identifers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/run_object_identifers/1").to route_to("run_object_identifers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/run_object_identifers/1").to route_to("run_object_identifers#destroy", :id => "1")
    end

  end
end
