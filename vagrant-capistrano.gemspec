# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant/capistrano/version'

Gem::Specification.new do |spec|
  spec.name          = "vagrant-capistrano"
  spec.version       = VagrantPlugins::Capistrano::VERSION
  spec.authors       = ["Martin Skinner"]
  spec.email         = ["martin@artcom.de"]
  spec.summary       = %q{Capistrano Provisioner for Vagrant}
  spec.description   = %q{Allows you to call capistrano from vargrant}
  spec.homepage      = "https://github.com/artcom/vagrant-capistrano"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
