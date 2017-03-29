module DeploymentTasks
  class Task 
    class << self
      def version
        task_file_path.split('_').first
      end

      def name
        File.basename(task_file_path, '.rb').split('_')[1..-1].join('_').classify
      end

      def task_file_path
        File.basename(self.method(:run!).source_location.first)
      end

      def logger(name = self.name, path = "log")
        Dir.mkdir("#{path}/deployment_tasks") unless File.exists?("#{path}/deployment_tasks")
        @logger ||= Hash.new()
        @logger[name.downcase] ||= Logger.new([path, "deployment_tasks/#{version}_#{name.downcase}.log"].join('/'))
      end
    end
  end
end
