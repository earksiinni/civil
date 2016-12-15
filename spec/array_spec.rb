require 'spec_helper'

RSpec.describe Civil::Array do
  describe "#new" do
    let(:arr) { Civil::Array.new([{ lol: 'hi' }]) }

    it 'returns an array containing Civil::Hash instances if passed a hash' do
      arr.each do |item|
        expect(item.is_a? Civil::Hash).to eq true
      end
    end
  end

  describe "#where" do
    let(:arr) { Civil::Array.new valid_items }
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
      it 'returns an array of hashes corresponding to the passed-in attributes' do
        valid_items.each do |attrs|
          expect(arr.where(attrs)).to eq Civil::Array.new([attrs])
        end
      end
    end

    context 'when passed in invalid attributes' do
      it "returns an empty array" do
        invalid_items.each do |attrs|
          expect(arr.where(attrs)).to eq Civil::Array.new
          expect(arr.where(attrs)).to be_empty
        end
      end
    end
  end

  describe "#pluck" do
    let(:arr) { Civil::Array.new valid_items }
    let(:valid_items) { [
      { id: 1, desc: 'hi' },
      { id: 2, desc: 'lol' }
    ] }

    context 'when passed in a valid key' do
      it 'returns an array of values' do
        valid_items.each do |attrs|
          attrs.each do |key, value|
            expect(arr.pluck(key)).to be_a Civil::Array
            expect(arr.pluck(key)).to include(value)
          end
        end
      end
    end

    context 'when passed in an invalid key' do
      it 'raises an error' do
        expect { arr.pluck(2378572.234) }.to raise_error ArgumentError
      end
    end

    context 'when passed in an empty key' do
      it 'raises an error' do
        expect { arr.pluck(nil) }.to raise_error ArgumentError
      end
    end
  end
end
