require 'spec_helper'

RSpec.describe Civil::Service do
  context 'can be included in service classes such that services' do
    let(:foo) { 5 }

    it 'can be called with .call' do
      expect { TestService.call(foo: foo) }.not_to raise_error
    end

    context 'when called' do
      let(:result) { TestService.call(foo: foo) }

      it 'return the output from the last step' do
        expect(result.data).to eq((foo + 3) * 2)
      end

      context 'when the service invokes add_condition' do
        let(:foo) { 99 }

        it 'adds a condition to the result' do
          conditions = result.conditions[:foo]

          expect(conditions).to contain_exactly("(first) foo is #{foo}", "(second) foo is #{foo}")
        end
      end

      context 'when the service invokes add_meta' do
        let(:foo) { 98 }

        it 'adds a metadatum to the result' do
          meta = result.meta[:foo]

          expect(meta).to contain_exactly("(first) foo is #{foo}", "(second) foo is #{foo}")
        end
      end
    end
  end
end
