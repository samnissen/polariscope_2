require 'rails_helper'

RSpec.describe BrowserType, type: :model do
  it_behaves_like "data from API" do
    let(:model) { BrowserType }
  end
end
