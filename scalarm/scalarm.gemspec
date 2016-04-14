# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scalarm/version'

Gem::Specification.new do |spec|
  spec.name          = 'scalarm'
  spec.version       = Scalarm::VERSION
  spec.authors       = ["Michał Begejowicz"]
  spec.email         = ['fanflm@gmail.com']

  spec.summary       = 'Gem with helper classes for Scalarm experiments'
  spec.description   = 'This module includes various classes which help in executing, parsing and generating ' \
                       'results from Scalarm experiments'
  spec.homepage      = ''
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)
  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'factory_girl'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'pry'
end
