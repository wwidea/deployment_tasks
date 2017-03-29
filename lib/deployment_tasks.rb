require "deployment_tasks/version"
require "deployment_tasks/table_name"
require "deployment_tasks/railtie" if defined?(Rails)
require "deployment_tasks/task"
require "deployment_tasks/runner"
require "active_record"
require "pry" if ENV['RACK_ENV'] == 'development'

module DeploymentTasks
  def self.run!
    Runner.new.run!
  end

  def self.rollback!(version = nil)
    Runner.new.rollback!(version)
  end
end
