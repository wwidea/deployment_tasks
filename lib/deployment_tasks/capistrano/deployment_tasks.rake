namespace :deployment_tasks do
  desc "Run Deployment Tasks"
  task :run do
    on roles(:db) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          require 'deployment_tasks'
          DeploymentTasks::Tasks.run!
        end
      end
    end
  end

  after "deploy:updated", "deployment_tasks:run"
end
