class TestTask < DeploymentTasks::Task
  def self.run!
    return "Test Task Ran!"
  end
end
