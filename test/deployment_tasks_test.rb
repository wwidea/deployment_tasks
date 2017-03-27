require 'test_helper'

class DeploymentTasksTest < Minitest::Test

  def setup
    Dir.mkdir("log") unless File.exists?("log")
  end

  def test_that_it_has_a_version_number
    refute_nil ::DeploymentTasks::VERSION
  end

  def test_that_run_works
    assert_equal Hash["123", "test/fixtures/123_test_task.rb"], ::DeploymentTasks::Tasks.run!
  end

  def test_that_rollback_works
    assert ::DeploymentTasks::Tasks.rollback!
  end

  def test_that_rollback_with_version_works
    assert ::DeploymentTasks::Tasks.rollback!('12')
  end

  def test_that_rollback_then_run_works
    assert ::DeploymentTasks::Tasks.rollback!('123')
    assert_equal Hash["123", "test/fixtures/123_test_task.rb"], ::DeploymentTasks::Tasks.run!
  end

end

module DeploymentTasks
  class Tasks
    private
    def file_require_path(filename)
      "test/fixtures/#{filename}"
    end
  end
end
