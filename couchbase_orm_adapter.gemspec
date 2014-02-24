# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'couchbase/orm_adapter/version'

Gem::Specification.new do |spec|
  spec.name          = "couchbase_orm_adapter"
  spec.version       = Couchbase::OrmAdapter::VERSION
  spec.authors       = ["Josh Williams"]
  spec.email         = ["jdubz@firma8.com"]
  spec.summary       = %q{orm_adapter for Couchbase::Model}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'orm_adapter'
  spec.add_dependency 'couchbase-model'
  spec.add_dependency 'activesupport'

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
