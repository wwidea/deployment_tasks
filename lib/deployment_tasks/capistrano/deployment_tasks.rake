namespace :deployment_tasks do
  desc "Run Deployment Tasks"
  task :run do
    within release_path do
        with rails_env: fetch(:rails_env) do
          execute 'rake', 'deployment_tasks:run'
        end
      end
  end

  after "deploy:updated", "deployment_tasks:run"
end
