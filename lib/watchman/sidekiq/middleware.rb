class Watchman
  module Sidekiq
    class Middleware
      def call(worker, job, queue)
        Watchman.benchmark(metric_name(queue, worker)) do
          yield
        end
      end

      def metric_name(queue, worker)
        worker_name = worker.class
                            .name
                            .gsub(/::/, '_')
                            .gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
                            .gsub(/([a-z\d])([A-Z])/,'\1_\2')
                            .tr("-", "_")
                            .downcase

        "sidekiq.#{queue}.#{worker_name}"
      end

    end
  end
end
