require 'rails_helper'

shared_examples "data from API" do
  context "models comprised of data from API" do
    it "instantiated instances of the model life unarchived" do
      instance = create(model.to_s.underscore.to_sym)
      expect(instance.archived).to eq(false)
    end
  end
end
