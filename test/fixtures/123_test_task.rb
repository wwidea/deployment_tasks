class TestTask < DeploymentTasks::Base
  def self.run!
    return "Test Task Ran!"
  end
end
