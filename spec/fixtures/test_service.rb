require 'civil'

class TestService
  include Civil::Service

  attr_accessor :result

  # Parameters
  attr_reader :foo

  service do
    validate_foo
    do_something
    do_something_else
  end

  private

  def validate_foo
    case foo
    when 99
      add_condition :foo, "(first) foo is #{foo}"
      add_condition :foo, "(second) foo is #{foo}"
    when 98
      add_meta :foo, "(first) foo is #{foo}"
      add_meta :foo, "(second) foo is #{foo}"
    end
  end

  def do_something
    self.result = foo + 3
  end

  def do_something_else
    self.result = result * 2
  end
end
