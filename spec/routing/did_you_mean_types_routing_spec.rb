require "rails_helper"

RSpec.describe DidYouMeanTypesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/did_you_mean_types").to route_to("did_you_mean_types#index")
    end

    it "routes to #new" do
      expect(:get => "/did_you_mean_types/new").to route_to("did_you_mean_types#new")
    end

    it "routes to #show" do
      expect(:get => "/did_you_mean_types/1").to route_to("did_you_mean_types#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/did_you_mean_types/1/edit").to route_to("did_you_mean_types#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/did_you_mean_types").to route_to("did_you_mean_types#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/did_you_mean_types/1").to route_to("did_you_mean_types#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/did_you_mean_types/1").to route_to("did_you_mean_types#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/did_you_mean_types/1").to route_to("did_you_mean_types#destroy", :id => "1")
    end

  end
end
