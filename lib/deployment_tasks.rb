require "deployment_tasks/version"
require "deployment_tasks/railtie" if defined?(Rails)
require "active_record"
require "pry" if ENV['RACK_ENV'] == 'development'

module DeploymentTasks
  class Tasks
    def self.run!
      new.run!
    end

    def run!
      tasks_to_run.each do |task|
        if load_and_execute(task.last)
          ActiveRecord::Base.connection.execute("insert into deployment_task (version) values (#{task.first})") 
          run_log.info "Successfully ran #{task.last}"
        end
      end
    end

    def self.rollback!(version=nil)
      new.rollback!(version)
    end

    def rollback!(version)
      version=(version || most_recent_version)
      rollback_log.info "Rolling back version=#{version}"
      ActiveRecord::Base.connection.execute("delete from deployment_task where version='#{version}'")
    end

    def most_recent_version
      previous_tasks.last
    end

    private

    def tasks_to_run
      load_tasks_from_files.except(*previous_tasks)
    end

    def load_and_execute(task)
      filename = task.split("/").last
      require   File.expand_path(file_require_path(filename))
      filename.split("_")[1..-1].join("_").split('.rb').first.classify.constantize.run!
    end

    def previous_tasks
      conn = ActiveRecord::Base.connection
      conn.select_values("select version from deployment_task order by `version` asc")
    end

    def load_tasks_from_files
      # get list of files, break into verion file_path pairs
      files = Dir[file_require_path("*")]
      return Hash[files.map {|file| [file.split('/').last.split('_').first, file] }]
    end

    def file_require_path(filename)
      "app/deployment_tasks/#{filename}"
    end

    def rollback_log
      Dir.mkdir("log/deployment_tasks") unless File.exists?("log/deployment_tasks")
      @rollback_log ||= Logger.new("log/deployment_tasks/rollback.log")
    end

    def run_log
      Dir.mkdir("log/deployment_tasks") unless File.exists?("log/deployment_tasks")
      @run_log ||= Logger.new("log/deployment_tasks/deployment_tasks_run.log")
    end
  end

  class Base
    class << self
      def version
        File.basename(self.method(:run!).source_location.first).split('_').first
      end
      def logger(name = self.name, path = "log")
        Dir.mkdir("#{path}/deployment_tasks") unless File.exists?("#{path}/deployment_tasks")
        @logger ||= Hash.new()
        @logger[name.downcase] ||= Logger.new([path, "deployment_tasks/#{version}_#{name.downcase}.log"].join('/'))
      end
    end
  end
end
