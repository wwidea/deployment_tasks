class CreateDeploymentTasksTable < ActiveRecord::Migration
  def up
    if ActiveRecord::Base.connection.data_source_exists? deployment_tasks_table
      if ActiveRecord::Base.connection.columns(deployment_tasks_table).map(&:name) == ["id", "version"]
        puts "Table `#{deployment_tasks_table}` and column `version` already exist!"
      else
        abort "`#{deployment_tasks_table}` table exists, but has unexpected columns, stopping to prevent data corruption, aborting."
      end
    else
      create_table deployment_tasks_table, id: false do |t|
        t.string :version
      end
    end
  end

  def down
    if ActiveRecord::Base.connection.columns(deployment_tasks_table).map(&:name) == ["id", "version"]
      drop_table deployment_tasks_table do |t|
        t.string :version
      end
    end
  end

  private
  def deployment_tasks_table
    DeploymentTasks.database_table_name
  end
end
