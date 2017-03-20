# DeploymentTasks

DeploymentTasks allows you to run tasks on deployment, usually these are data migrations, however, you are not limited to this, you can run any ruby code you wish.  

DeploymentTasks are setup like database migrations, the files are versioned, and the tasks that have run have their version stored in the database.  Unlike database
migrations, there is no hard dependency on the tasks having run, to run a rails app.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'deployment_tasks'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install deployment_tasks

## Capistrano (optional)

To automatically run deployment tasks on deploy, include:
```ruby
require 'deployment_tasks/capistrano'
```
And ensure you have included `capistrano-rails` as well.
```ruby
require 'capistrano/rails'
```

## Usage

Execute:

    $ rails generate deployment_task NAME
    
This will create:

  `app/deployment_tasks/[VERSION]_[NAME].rb`

  `test/deployment_tasks[VERSION]_[NAME]_test.rb`

It will also create the migration file for the `deployment_tasks` table if no such table exists.

  `db/migrate/[VERSION]_create_deployment_tasks_table.deployment_tasks.rb`



## Rake
You can run the deployment tasks as a rake task as well.

    $ rake deployment_tasks:run

If you wish to allow a task to run again, you can use rollback(which remove the recored of having run the task, it will NOT undo whatever the task did.)

    $ rake deployment_tasks:rollback [version=VERSION]

## Rails console
To run all un-run tasks:

    irb> DeploymentTasks::Tasks.run!

To rollback the last task:

    irb> DeploymentTasks::Tasks.rollback!

To rollback a specific task:

    irb> DeploymentTasks::Task.rollback!("VERSION")


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wwidea/deployment_tasks.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
