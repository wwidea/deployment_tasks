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

Then add this to your Capfile
```ruby
require 'deployment_tasks/capistrano'
```

## Usage

Execute:

    $ rails generate deployment_task NAME
    
This will create:

  `app/deployment_tasks/[VERSION]_[NAME].rb`

  `test/deployment_tasks[VERSION]_[NAME]_test.rb`


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wwidea/deployment_tasks.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
