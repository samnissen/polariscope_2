require "rails_helper"

RSpec.describe DataElementsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/data_elements").to route_to("data_elements#index")
    end

    it "routes to #new" do
      expect(:get => "/data_elements/new").to route_to("data_elements#new")
    end

    it "routes to #show" do
      expect(:get => "/data_elements/1").to route_to("data_elements#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/data_elements/1/edit").to route_to("data_elements#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/data_elements").to route_to("data_elements#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/data_elements/1").to route_to("data_elements#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/data_elements/1").to route_to("data_elements#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/data_elements/1").to route_to("data_elements#destroy", :id => "1")
    end

  end
end
