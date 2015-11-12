# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'extort/version'

Gem::Specification.new do |spec|
  spec.name          = "extort"
  spec.version       = Extort::VERSION
  spec.authors       = ["DK"]
  spec.email         = ["dk@nutshell.nl"]
  spec.summary       = %q{Extort adds migrations to Sinatra or any other rake based framework}
  spec.description   = %q{Extort sets up Sequel migrations for Rack frameworks}
  spec.homepage      = "http://github.com/amaniak/extort"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "pry", "~> 0.10.1"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "sequel", "~> 4.28.0"
end
