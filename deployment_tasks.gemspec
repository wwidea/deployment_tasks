# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'deployment_tasks/version'

Gem::Specification.new do |spec|
  spec.name          = "deployment_tasks"
  spec.version       = DeploymentTasks::VERSION
  spec.authors       = ["David Gross"]
  spec.email         = ["david.gross@daggerweb.org"]

  spec.summary       = %q{Run Data Migrations, or other code in a deployment}
  spec.description   = %q{Deployment Tasks allow Data Migrations or other jobs to be run on deploy, with the expectation that they will run once, and only once.  Repetitive jobs should use Rails Jobs, and tasks run on each deploy should be in cap or whatever deploy system you use.}
  spec.homepage      = "https://github.com/wwidea/deployment_tasks"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", "~> 5.0.0"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rails", "~> 5.0.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry"
end
