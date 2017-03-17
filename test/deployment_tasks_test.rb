require 'test_helper'

class DeploymentTasksTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::DeploymentTasks::VERSION
  end

end
