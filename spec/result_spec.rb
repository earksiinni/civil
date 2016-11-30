require 'spec_helper'

RSpec.describe Civil::Result do
  let(:data) { 123 }

  describe 'a result' do
    context 'when there is no data' do
      it "can't be created" do
        expect{ Civil::Result.new }.to raise_error ArgumentError
      end
    end

    context 'when there are no conditions' do
      let(:result) { Civil::Result.new data }

      it 'is ideal' do
        expect(result).to be_ideal
      end

      it "isn't deviant" do
        expect(result).not_to be_deviant
      end

      it 'contains no conditions' do
        expect(result.conditions).to eq({})
      end
    end

    context 'when there are conditions' do
      let(:conditions) { { foo: 'is too small' } }
      let(:result) { Civil::Result.new data, conditions }

      it "isn't ideal" do
        expect(result).not_to be_ideal
      end

      it 'is deviant' do
        expect(result).to be_deviant
      end

      it 'contains conditions' do
        expect(result.conditions).to eq conditions
      end
    end

    context 'when there is metadata' do
      let(:meta) { { bar: 'xyz' } }
      let(:result) { Civil::Result.new data, {}, meta }

      it 'contains meta' do
        expect(result.meta).to eq meta
      end
    end

    context "when there isn't metadata" do
      let(:result) { Civil::Result.new data }

      it 'contains no meta' do
        expect(result.meta).to eq({})
      end
    end
  end
end
