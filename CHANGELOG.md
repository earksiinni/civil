# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

## [1.1.0] - 2016-12-2
### Added
- You can now run services by passing in blocks to `call`. The service will
  only run the methods in the block:

  ```ruby
  MyService.call do
    step_one
    # Normally, step two would get run, but let's skip it this time
    # step_two
    step_three

    result
  end
  ```

  If you've already defined steps inside the service class in a `service`
  block, that's OK, the passed-in block will override.

## [1.0.0] - 2016-11-30
### Changed
- Result conditions and meta now store keyed arrays of data instead of key/value pairs

## 0.1.0 - 2016-11-30
### Added
- Initial commit, imported files that I had originally written for [StandardService](https://github.com/TheTroveApp/standard-service)
- Civil::Result and Civil::Service classes
- Specs for Civil::Result and Civil::Service
- Various bits of tooling for RVM, Rake, RSpec, etc.
- Documentation and examples in README.md
- This changelog :-)

[Unreleased]: https://github.com/earksiinni/civil/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/earksiinni/civil/compare/v0.1.0...v1.0.0
