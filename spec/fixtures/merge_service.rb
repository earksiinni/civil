require 'civil'
require 'fixtures/test_service'

class MergeService
  include Civil::Service

  # parameters
  attr_reader :foo

  service do
    merge_result TestService.call(foo: foo)
  end
end
