$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'deployment_tasks'

require 'minitest/autorun'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

require_relative 'db/schema.rb'
