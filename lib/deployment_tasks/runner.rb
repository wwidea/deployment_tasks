module DeploymentTasks
  class Runner
    def run!
      tasks_to_run.each do |task|
        task.run!
        ActiveRecord::Base.connection.execute("insert into #{DeploymentTasks.database_table_name} (version) values (#{task.version})") 
        run_log.info "Successfully ran #{task.name}"
      end
    end

    def rollback!(version = most_recent_version)
      rollback_log.info "Rolling back version=#{version}"
      ActiveRecord::Base.connection.execute("delete from #{DeploymentTasks.database_table_name} where version='#{version}'")
    end

    def most_recent_version
      previous_tasks.last
    end

    private

    def tasks_to_run
      load_tasks_from_files.reject {|task| previous_tasks.include?(task.version) }.sort {|x,y| x.version <=> y.version }
    end

    def previous_tasks
      conn = ActiveRecord::Base.connection
      conn.select_values("select version from #{DeploymentTasks.database_table_name} order by `version` asc")
    end

    def load_tasks_from_files
      # get list of files, break into verion file_path pairs
      files = Dir[file_require_path("*")]
      files.map {|file| class_from_file(file)}
    end

    def class_from_file(file)
      load file
      File.basename(file, '.rb').split('_')[1..-1].join('_').classify.constantize
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
end
