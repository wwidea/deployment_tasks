namespace :deployment_tasks do
  desc "Run Deployment Tasks"
  task :run => :environment do
    require 'deployment_tasks'
    DeploymentTasks::Tasks.run!
  end

  task :rollback => :environment do
    DeploymentTasks::Tasks.rollback!(ENV['version'])
  end
end
