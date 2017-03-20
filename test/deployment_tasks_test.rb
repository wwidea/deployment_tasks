require 'test_helper'

class DeploymentTasksTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::DeploymentTasks::VERSION
  end

  def test_that_run_works
    assert ::DeploymentTasks::Tasks.run!
  end

  def test_that_rollback_works
    assert ::DeploymentTasks::Tasks.rollback!
  end

  def test_that_rollback_with_version_works
    assert ::DeploymentTasks::Tasks.rollback!('123')
  end
end
