require "spec_helper"

describe Watchman::Sidekiq::Middleware do

  class TestJob
    include Sidekiq::Worker

    def perform(name)
      puts "Doing: #{name}"
    end
  end

  it "collects benchmark information for every job" do
    expect(Watchman).to receive(:benchmark).with("sidekiq.default.test_job").and_call_original

    TestJob.perform_async("test")
  end

  it "performs the sidekiq action" do
    expect { TestJob.perform_async("test") }.to output(/Doing: test/).to_stdout
  end

  describe "queue names" do

    class TestJobWithSpecialQueue
      include Sidekiq::Worker
      sidekiq_options :queue => "critical"

      def perform(name)
        puts "Doing: #{name}"
      end
    end

    it "includes the queue name in the metric" do
      expect(Watchman).to receive(:benchmark).with("sidekiq.critical.test_job_with_special_queue").and_call_original

      TestJobWithSpecialQueue.perform_async("test")
    end

  end

  describe "nested worker names" do

    module Submodule
      class TestJob
        include Sidekiq::Worker

        def perform(name)
          puts "Doing: #{name}"
        end
      end
    end

    it "includes the queue name in the metric" do
      expect(Watchman).to receive(:benchmark).with("sidekiq.default.submodule_test_job").and_call_original

      Submodule::TestJob.perform_async("test")
    end

  end

end
