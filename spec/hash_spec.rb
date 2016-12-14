require 'spec_helper'

RSpec.describe Civil::Hash do
  describe "#=~" do
    let(:hash) { Civil::Hash.new.merge!(valid_attrs) }
    let(:valid_attrs) { { hi: '1', lol: 2 } }
    let(:invalid_attrs) { { foobar: '1' } }

    it 'returns true if the hash contains passed-in attributes' do
      expect(hash =~ valid_attrs).to eq true
    end

    it "returns false if the hash doesn't contain passed-in attributes" do
      expect(hash =~ invalid_attrs).to eq false
    end
  end
end
