# Watchman Sidekiq

[![Gem Version](https://badge.fury.io/rb/watchman-sidekiq.svg)](https://badge.fury.io/rb/watchman-sidekiq)
[![Build Status](https://semaphoreci.com/api/v1/shiroyasha/watchman-sidekiq/branches/master/badge.svg)](https://semaphoreci.com/shiroyasha/watchman-sidekiq)

[Watchman](https://github.com/renderedtext/watchman) extensions for sidekiq.

Watchman Sidekiq collects benchmarks for all of your workers.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'watchman-sidekiq'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install watchman-sidekiq

## Usage

First, include the watchman middleware in your Sidekiq call stack:

``` ruby
Sidekiq.configure_server do |config|
  config.server_middleware do |chain|
    chain.add Watchman::Sidekiq::Middleware
  end
end
```

Now, if you have a sidekiq worker:

``` ruby
class ExampleJob
  include Sidekiq::Worker
  sidekiq_option :queue => "critical"

  def perform
    puts "Example Job"
  end
end
```

And perform a job:

``` ruby
ExampleJob.perform_async
```

The following watchman metric will be collected:

```
sidekiq.critical.example_job
```

More generally, the format of the metric name is the following:

```
sidekiq.<queue_name>.<worker_name>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then,
run `rake spec` to run the tests. You can also run `bin/console` for an
interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then
run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file
to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/shiroyasha/watchman-sidekiq. This project is intended to be
a safe, welcoming space for collaboration, and contributors are expected to
adhere to the [Contributor Covenant](http://contributor-covenant.org)
code of conduct.

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).
