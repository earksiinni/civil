# Civil

An opinionated Ruby framework for standardizing services, their inputs and their outputs. [![Build Status](https://travis-ci.org/earksiinni/civil.svg?branch=master)](https://travis-ci.org/earksiinni/civil)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'civil'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install civil

## Getting started

Write your service:

```ruby
class MyService
  include Civil::Service

  # Use attribute readers for input parameters
  attr_reader :foo
  attr_accessor :buffer

  service do
    do_something
    do_something_else
  end

  def do_something
    self.buffer = foo + 3
  end

  def do_something_else
    self.buffer = buffer * 2
  end
end
```

Invoke your service:

```ruby
# Pass input parameters in hash
result = MyService.call foo: 10

result.data       # 26; result.data == the last return value from inside the service block
result.conditions # {}; add conditions to indicate non-happy path results (see below)
result.meta       # {}
result.ideal?     # true; because there are no conditions
result.deviant?   # false
```

## Usage

### Conditions

Civil distinguishes between "errors" and "conditions":

- An error results from an unexpected behavior that has nothing to do with your business logic. For example, a user attempting to access an unauthorized resource.
- A condition results from an expected behavior that deviates from the happy path in your business logic. For example, a user attempting to upload an avatar image that's too big.

Civil currently doesn't handle errors. To add a condition, use `#add_condition`:

```ruby
class SaveAvatarImage
  ...

  def check_image_size
    add_condition :image_too_big, "The uploaded image must be < 1 MB in size" if image_size_too_big?
  end
end
```

Your condition will be available in your result:

```ruby
result = SaveAvatarImage.call image: image

result.conditions # { image_too_big: "The uploaded image must be < 1 MB in size" }
result.ideal?     # false
result.deviant?   # true
```

Results from service calls that have no conditions are said to be "ideal" whereas those with conditions are said to be "deviant." Two helper methods, `ideal?` and `deviant?`, provide shortcuts for checking for the presence of conditions. Note that we intentionally avoid the commonly used terms "success" and "failure" as these relate to errors, not conditions.

### Metadata

Metadata can be returned with any ideal or deviant result by using `add_meta`:

```ruby
class MetadataExample
  ...

  def process_doodad
    add_meta :length, 12.5
  end
end

result = MetadataExample.call doodad: doodad

result.meta # { length: {12.5} }
```

### Overriding the service block

You can override the steps defined within your service class' `service` block
by passing a block to `call`:

```ruby
class MyService
  service do
    step_one
    step_two
    result
  end

  ...
end

# The following will skip step_two
result = MyService.call { step_one; result; }
```

### Filtering

Filter metadata and results by using `where`:

```ruby
class BuildCars
  ...

  def trigger_some_conditions_and_metadata
    if make == 'Wondercar'
      add_condition :cars, { make: 'Wondercar', msg: 'no such make' }
      add_condition :cars, { make: 'Wondercar', msg: 'not a thing' }
      add_meta :cars, { make: 'Wondercar', msg: 'pretty cool name, though' }
    end
  end
end

result = BuildCars.call(makes: ['Wondercar', 'Lamecar', 'Hamilcar'])

result.conditions[:cars].where(make: 'Wondercar') # {{ make: 'Wondercar', msg: 'no such make'}, { make: 'Wondercar', msg: 'not a thing'}}
result.conditions[:cars].where(make: 'Wondercar', msg: 'not a thing') # {{ make: 'Wondercar', msg: 'not a thing'}}
result.meta[:cars].where(make: 'Wondercar') # {{ make: 'Wondercar', msg: 'pretty cool name, though' }}
```

For filtering to work properly, you must pass a hash or an instance of
`Civil::Hash` to `add_condition`/`add_meta`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/earksiinni/civil. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
