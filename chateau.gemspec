# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chateau/version'

Gem::Specification.new do |spec|
  spec.name          = "chateau"
  spec.version       = Chateau::VERSION
  spec.authors       = ["Alan Skorkin"]
  spec.email         = ["alan@skorks.com"]
  spec.description   = %q{The nice Hipchat API gem}
  spec.summary       = %q{The nice Hipchat API gem}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "hipchat-api"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
