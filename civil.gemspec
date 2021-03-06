# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'civil/version'

Gem::Specification.new do |spec|
  spec.name          = "civil"
  spec.version       = Civil::VERSION
  spec.authors       = ["Ersin Akinci"]
  spec.email         = ["ersin.akinci@gmail.com"]

  spec.summary       = %q{Standardize your services, their inputs and their outputs}
  spec.description   = %q{Services help keep your business logic clean, but what helps keep your services clean? Civil provides a framework for writing services that all have a standardized structure, inputs and outputs.}
  spec.homepage      = "https://github.com/earksiinni/civil"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_development_dependency "pry", "~> 0.10"
end
