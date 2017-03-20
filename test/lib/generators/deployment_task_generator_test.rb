require 'test_helper'
require 'generators/deployment_task/deployment_task_generator'

class DeploymentTaskGeneratorTest < Rails::Generators::TestCase
  tests DeploymentTaskGenerator
  root = File.expand_path("..", __FILE__)
  destination "#{root}/tmp/generators"
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
