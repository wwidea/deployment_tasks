require 'test_helper'
require 'pry'
require 'generators/deployment_task/deployment_task_generator'

class DeploymentTaskGeneratorTest < Rails::Generators::TestCase
  tests DeploymentTaskGenerator
  root = File.expand_path("../../..", __FILE__)
  destination "#{root}/tmp/generators"
  setup :prepare_destination

  test "generator runs without errors" do
    assert_nothing_raised do
      run_generator ["TestGenerator"]
    end
    assert_file "#{root}/tmp/generators/app/deployment_tasks/"
    assert_file "#{root}/tmp/generators/test/deployment_tasks/"
  end
end
