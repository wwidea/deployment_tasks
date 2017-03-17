require 'capistrano/version'

if defined?(Capistrano::VERSION) && Gem::Version.new(Capistrano::VERSION).release >= Gem::Version.new('3.0.0')
  load File.expand_path("../capistrano/deployment_tasks.rake", __FILE__)
else
  abort "You must have Capistrano V3 to use this gem!"
end
