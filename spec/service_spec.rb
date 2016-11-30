require 'spec_helper'

RSpec.describe Civil::Service do
  class TestService
    include Civil::Service

    attr_accessor :result

    # Parameters
    attr_reader :foo

    service do
      do_something
      do_something_else
    end

    private

    def do_something
      self.result = foo + 3
    end

    def do_something_else
      self.result = result * 2
    end
  end

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
