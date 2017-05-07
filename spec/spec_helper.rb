require "bundler/setup"
require "watchman/sidekiq"

require 'sidekiq/testing'
Sidekiq::Testing.inline!

Sidekiq::Testing.server_middleware do |chain|
  chain.add Watchman::Sidekiq::Middleware
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
