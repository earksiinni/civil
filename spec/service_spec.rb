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

      context 'when filtering results' do
        let(:foo) { 97 }

        it 'only returns the appropriate conditions and metadata' do
          valid_conditions = result.conditions[:foo].where(id: 1)
          invalid_conditions = result.conditions[:foo].where(id: 999)
          valid_meta = result.meta[:baz].where(id: 2)
          invalid_meta = result.meta[:baz].where(cow: 'moo')

          expect(valid_conditions).to include({ id: 1, msg: 'bar' })
          expect(invalid_conditions).to be_empty
          expect(valid_meta).to include({ id: 2, msg: 'qux' })
          expect(invalid_meta).to be_empty
          expect(valid_conditions.pluck(:id)).to include 1
          expect(valid_conditions.pluck(:id)).not_to include 2
        end
      end
    end

    context 'when called with a block' do
      let(:result) { TestService.call(foo: foo) { do_something; result } }

      it 'only calls the methods passed in' do
        expect(result.data).to eq(foo + 3)
      end
    end
  end
end
