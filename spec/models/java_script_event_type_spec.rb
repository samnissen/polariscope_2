require 'rails_helper'

RSpec.describe JavaScriptEventType, type: :model do
  it_behaves_like "data from API" do
    let(:model) { JavaScriptEventType }
  end
end
