# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scribesoft/version'

Gem::Specification.new do |spec|
  spec.name          = "scribesoft"
  spec.version       = Scribesoft::VERSION
  spec.authors       = ["Joe Heth"]
  spec.email         = ["joeheth@gmail.com"]
  spec.summary       = %q{Interacts with Scribe Software's RESTful API}
  spec.description   = %q{Perform RESTful actions against Scribe Software's API}
  spec.homepage      = "https://endpoint.scribesoft.com/Swagger/Overview"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_development_dependency "httparty", "~> 0.13.3"
  spec.add_development_dependency "awesome_print", "~> 1.6.1", "< 1.7"
end
