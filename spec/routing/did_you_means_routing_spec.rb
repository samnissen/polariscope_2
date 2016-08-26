require "rails_helper"

RSpec.describe DidYouMeansController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/did_you_means").to route_to("did_you_means#index")
    end

    it "routes to #new" do
      expect(:get => "/did_you_means/new").to route_to("did_you_means#new")
    end

    it "routes to #show" do
      expect(:get => "/did_you_means/1").to route_to("did_you_means#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/did_you_means/1/edit").to route_to("did_you_means#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/did_you_means").to route_to("did_you_means#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/did_you_means/1").to route_to("did_you_means#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/did_you_means/1").to route_to("did_you_means#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/did_you_means/1").to route_to("did_you_means#destroy", :id => "1")
    end

  end
end
