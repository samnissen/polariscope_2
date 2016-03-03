require 'rails_helper'

RSpec.describe Selector, type: :model do
  it_behaves_like "data from API" do
    let(:model) { Selector }
  end
end
