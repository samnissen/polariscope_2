require "rails_helper"

RSpec.describe EnvironmentsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/environments").to route_to("environments#index")
    end

    it "routes to #new" do
      expect(:get => "/environments/new").to route_to("environments#new")
    end

    it "routes to #show" do
      expect(:get => "/environments/1").to route_to("environments#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/environments/1/edit").to route_to("environments#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/environments").to route_to("environments#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/environments/1").to route_to("environments#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/environments/1").to route_to("environments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/environments/1").to route_to("environments#destroy", :id => "1")
    end

  end
end
