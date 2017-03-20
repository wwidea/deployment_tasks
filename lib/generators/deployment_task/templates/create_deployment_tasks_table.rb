class CreateDeploymentTasksTable < ActiveRecord::Migration
  def up
    if ActiveRecord::Base.connection.data_source_exists? 'deployment_task'
      if ActiveRecord::Base.connection.columns("deployment_task").map(&:name) == ["id", "version"]
        puts "Table `deployment_task` and column `version` already exist!"
      else
        abort "deployment_tasks table exists, but has unexpected columns, stopping to prevent data corruption, aborting."
      end
    else
      create_table :deployment_task do |t|
        t.string :version
      end
    end
  end

  def down
    if ActiveRecord::Base.connection.columns("deployment_task").map(&:name) == ["id", "version"]
      drop_table :deployment_task do |t|
        t.string :version
      end
    end
  end
end
