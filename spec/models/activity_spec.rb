require 'rails_helper'

RSpec.describe Activity, type: :model do
  it_behaves_like "data from API" do
    let(:model) { Activity }
  end
end
