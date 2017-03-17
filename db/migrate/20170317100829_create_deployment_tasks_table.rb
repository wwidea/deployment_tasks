class CreateDeploymentTasksTable < ActiveRecord::Migration
  def change
    create_table :deployment_task do |t|
      t.string :version
    end
  end
end
