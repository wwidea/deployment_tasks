namespace :deployment_tasks do
  desc "Run Deployment Tasks"
  task :run => :environment do
    require 'deployment_tasks'
    DeploymentTasks.run!
  end

  desc "Remove the version passed/last version from the database, allowing the task to be run again"
  task :rollback => :environment do
    require 'deployment_tasks'
    DeploymentTasks.rollback!(ENV['version'])
  end
end
