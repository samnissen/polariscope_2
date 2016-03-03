require 'rails_helper'

RSpec.describe ObjectType, type: :model do
  it_behaves_like "data from API" do
    let(:model) { ObjectType }
  end
end
