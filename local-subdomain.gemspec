# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'local-subdomain/version'

Gem::Specification.new do |spec|
  spec.name          = 'local-subdomain'
  spec.version       = LocalSubdomain::VERSION
  spec.authors       = ['Manuel van Rijn']
  spec.email         = ['manuel@manuelvanrijn.nl']

  spec.summary       = 'subdomain support in your development environment'
  spec.description   = "This gem helps out when your application depends on subdomain support and you don't want to modify you /etc/hosts file all the time for your development environment."
  spec.homepage      = 'https://github.com/manuelvanrijn/local-subdomain'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
end
