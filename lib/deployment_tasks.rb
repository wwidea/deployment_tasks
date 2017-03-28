require "deployment_tasks/version"
require "deployment_tasks/railtie" if defined?(Rails)
require "deployment_tasks/base"
require "deployment_tasks/tasks"
require "active_record"
require "pry" if ENV['RACK_ENV'] == 'development'

module DeploymentTasks
  def self.run!
    Tasks.new.run!
  end

  def self.rollback!(version=nil)
    Tasks.new.rollback!(version)
  end
end
