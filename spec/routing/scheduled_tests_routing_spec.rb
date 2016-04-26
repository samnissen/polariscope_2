require "rails_helper"

RSpec.describe ScheduledTestsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/scheduled_tests").to route_to("scheduled_tests#index")
    end

    it "routes to #new" do
      expect(:get => "/scheduled_tests/new").to route_to("scheduled_tests#new")
    end

    it "routes to #show" do
      expect(:get => "/scheduled_tests/1").to route_to("scheduled_tests#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/scheduled_tests/1/edit").to route_to("scheduled_tests#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/scheduled_tests").to route_to("scheduled_tests#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/scheduled_tests/1").to route_to("scheduled_tests#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/scheduled_tests/1").to route_to("scheduled_tests#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/scheduled_tests/1").to route_to("scheduled_tests#destroy", :id => "1")
    end

  end
end
