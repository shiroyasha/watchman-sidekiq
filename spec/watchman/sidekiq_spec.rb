require "spec_helper"

RSpec.describe Watchman::Sidekiq do
  it "has a version number" do
    expect(Watchman::Sidekiq::VERSION).not_to be nil
  end
end
