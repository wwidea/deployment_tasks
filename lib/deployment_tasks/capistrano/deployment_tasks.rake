namespace :deployment_tasks do
  desc "Run Deployment Tasks"
  task :run do
    require 'deployment_tasks'
    DeploymentTasks::Tasks.run!
  end

  after "deploy:updated", "deployment_tasks:run"
end
