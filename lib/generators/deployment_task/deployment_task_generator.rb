class DeploymentTaskGenerator < Rails::Generators::NamedBase
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

  private

  def version
    @version ||= DateTime.now.to_s(:number)
  end

  def klassname
    @klassname ||= file_name.classify
  end
end
