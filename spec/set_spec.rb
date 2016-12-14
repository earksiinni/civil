require 'spec_helper'

RSpec.describe Civil::Set do
  describe "#new" do
    let(:set) { Civil::Set.new([{ lol: 'hi' }]) }

    it 'returns a set containing Civil::Hash instances if passed a hash' do
      set.each do |item|
        expect(item.is_a? Civil::Hash).to eq true
      end
    end
  end

  describe "#where" do
    let(:set) { Civil::Set.new valid_items }
    let(:valid_items) { [
      { id: 1, desc: 'hi' },
      { id: 2, desc: 'lol'}
    ] }
    let(:invalid_items) { [
      { foobar: 1 },
      { id: 2, desc: 'not lol' },
      { id: 2, desc: nil },
      { id: 3 }
    ] }

    context 'when passed in valid attributes' do
      it 'returns a set of hashes corresponding to the passed-in attributes' do
        valid_items.each do |attrs|
          expect(set.where(attrs)).to eq Civil::Set.new([attrs])
        end
      end
    end

    context 'when passed in invalid attributes' do
      it "returns an empty set" do
        invalid_items.each do |attrs|
          expect(set.where(attrs)).to eq Civil::Set.new
          expect(set.where(attrs)).to be_empty
        end
      end
    end
  end
end
