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
    end
  end
end
