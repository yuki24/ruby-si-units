# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'si_units/version'

Gem::Specification.new do |spec|
  spec.name          = "tuby-si-units"
  spec.version       = SIUnits::VERSION
  spec.authors       = ["Kenner Kliemann"]
  spec.email         = ["kenner.hp@gmail.com"]
  spec.description   = "A SI prefix unit handling library for ruby"
  spec.summary       = "A SI prefix unit handling library for ruby"
  spec.homepage      = "https://github.com/gnomex/ruby-si-units"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
