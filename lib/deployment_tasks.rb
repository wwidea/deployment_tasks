require "deployment_tasks/version"
require "deployment_tasks/railtie" if defined?(Rails)
require "active_record"
require "pry" if ENV['RACK_ENV'] == 'development'

module DeploymentTasks
  class Tasks
    def self.run!
      new.run!
    end

    def self.rollback!(version=nil)
      version=(version || new.most_recent_version)
      ActiveRecord::Base.connection.execute("delete from deployment_task where version='#{version}'")
    end

    def run!
      tasks_to_run.each do |task|
        ActiveRecord::Base.connection.execute("insert into deployment_task (version) values (#{task.first})") if load_and_execute(task.last)
      end
    end

    def most_recent_version
      previous_tasks.last
    end

    private

    def load_and_execute(task)
      filename = task.split("/").last
      require File.expand_path("app/deployment_tasks/#{filename}")
      filename.split("_")[1..-1].join("_").split('.rb').first.classify.constantize.run!
    end

    def previous_tasks
      conn = ActiveRecord::Base.connection
      conn.select_values("select version from deployment_task order by `version` asc")
    end

    def load_tasks_from_files
      # get list of files, break into verion file_path pairs
      files = Dir['app/deployment_tasks/*']
      return Hash[files.map {|file| [file.split('/').last.split('_').first, file] }]
    end

    def tasks_to_run
      load_tasks_from_files.except(*previous_tasks)
    end
  end

  class Base
    class << self
      def logger(name, path = "log")
        @logger ||= Hash.new()
        @logger[name.downcase] ||= Logger.new([path, "deployment_tasks_#{name.downcase}.log"].join('/'))
      end
    end
  end
end
