require 'test_helper'

class DeploymentTasksTest < Minitest::Test

  def setup
    load "test/fixtures/123_test_task.rb"
    ActiveRecord::Base.connection.execute("delete from #{::DeploymentTasks.database_table_name}")
  end

  def test_that_it_has_a_version_number
    refute_nil ::DeploymentTasks::VERSION
  end

  def test_that_run_works
    assert_equal [TestTask], ::DeploymentTasks.run!
  end

  def test_that_rollback_works
    assert ::DeploymentTasks.rollback!
  end

  def test_that_rollback_with_version_works
    assert ::DeploymentTasks.rollback!('12')
  end

  def test_that_rollback_then_run_works
    assert_equal [TestTask], ::DeploymentTasks.run!
    assert ::DeploymentTasks.rollback!('123')
    assert_equal [TestTask], ::DeploymentTasks.run!
  end

end

module DeploymentTasks
  class Runner
    private
    def file_require_path(filename)
      "test/fixtures/#{filename}"
    end
  end
end
