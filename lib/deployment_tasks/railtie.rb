class DeploymentTasks::Railtie < Rails::Railtie
  rake_tasks do
    load 'tasks/deployment_tasks.rake'
  end
end
