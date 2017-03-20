require "rails/generators"
require "rails/generators/named_base"

class DeploymentTaskGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)

  def create_task_file
    create_file "app/deployment_tasks/#{version}_#{file_name}.rb" do
      "class #{klassname}\n" +
      "  def self.run!\n" +
      "   # Do Something\n" +
      "  end\n" +
      "end\n"
    end
  end
  
  def create_test_file
    create_file "test/deployment_tasks/#{version}_#{file_name}.rb" do
      "class #{klassname}Test < ActiveSupport::TestCase\n" +
      "  test 'test deploy task'\n" +
      "    assert false\n" +
      "  end\n" +
      "end\n"
    end
  end

  def create_migration_file
    unless ActiveRecord::Base.connection.data_source_exists? 'deployment_task'
      copy_file "create_deployment_tasks_table.rb", "db/migrate/#{DateTime.now.to_s(:number)}_create_deployment_tasks_table.deployment_tasks.rb"
    end
  end

  private

  def version
    @version ||= DateTime.now.to_s(:number)
  end

  def klassname
    @klassname ||= file_name.classify
  end
end
