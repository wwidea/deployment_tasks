namespace :deployment_tasks do
  desc "Run Deployment Tasks"
  task :run do
    DeploymentTasks::Tasks.run!
  end

  after "deploy:updated", "deployment_tasks:run"
end
