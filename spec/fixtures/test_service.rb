require 'civil'

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
