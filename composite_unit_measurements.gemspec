# -*- encoding: utf-8 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "composite_unit_measurements/version"

Gem::Specification.new do |spec|
  spec.name = "composite_unit_measurements"
  spec.version = CompositeUnitMeasurements::VERSION
  spec.authors = ["Harshal LADHE"]
  spec.email = ["harshal.ladhe.1@gmail.com"]

  spec.summary = "A set of specialized parsers for dealing with composite measurement strings."
  spec.description = spec.summary
  spec.homepage = "https://github.com/shivam091/composite_unit_measurements"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.2"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/shivam091/composite_unit_measurements"
  spec.metadata["changelog_uri"] = "https://github.com/shivam091/composite_unit_measurements/blob/main/CHANGELOG.md"
  spec.metadata["documentation_uri"] = "https://shivam091.github.io/composite_unit_measurements"
  spec.metadata["bug_tracker_uri"] = "https://github.com/shivam091/composite_unit_measurements/issues"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport", "~> 7.0"
  spec.add_runtime_dependency "unit_measurements", "~> 5"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "simplecov", "~> 0.21", ">= 0.21.2"
  spec.add_development_dependency "byebug", "~> 11"
end
