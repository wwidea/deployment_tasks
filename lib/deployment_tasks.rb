require "deployment_tasks/version"
require "active_record"
require "pry" if ENV['RACK_ENV'] == 'development'

module DeploymentTasks
  class Tasks
    def self.run!
      new.run!
    end

    def run!
      tasks_to_run.each do |task|
        ActiveRecord::Base.connection.execute("insert into deployment_task (version) values (#{task.first})") if load_and_execute(task)
      end
    end

    private

    def load_and_execute(task)
      filename = task.split("/").last
      require filename
      filename.split("_")[1..-1].join("_").split('.rb').first.classify.constantize.run!
    end

    def previous_tasks
      conn = ActiveRecord::Base.connection
      conn.select_values("select version from deployment_task")
    end

    def load_tasks_from_files
      # get list of files, break into verion file_path pairs
      files = Dir['app/deployment_tasks/*']
      return Hash[files.map {|file| [file.split('/').last.split('_').first, file] }]
    end

    def tasks_to_run
      load_tasks_from_files.except(*previous_tasks).values
    end
  end
end
