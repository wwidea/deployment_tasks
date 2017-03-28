namespace :deployment_tasks do
  desc "Run Deployment Tasks"
  task :run => :environment do
    require 'deployment_tasks'
    DeploymentTasks.run!
  end

  task :rollback => :environment do
    require 'deployment_tasks'
    DeploymentTasks.rollback!(ENV['version'])
  end
end
