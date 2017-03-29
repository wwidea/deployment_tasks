module DeploymentTasks
  class Task 
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
