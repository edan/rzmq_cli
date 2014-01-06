# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rzmq_cli/version'

Gem::Specification.new do |spec|
  spec.name          = "rzmq_cli"
  spec.version       = RzmqCli::VERSION
  spec.authors       = ["edan"]
  spec.email         = ["edan@edan.org"]
  spec.description   = "Command Line Interface for zeromq written in ruby"
  spec.summary       = "Command Line Interface for zeromq written in ruby"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "debugger"
  spec.add_dependency "ffi-rzmq"
  spec.add_dependency "docopt"
end
