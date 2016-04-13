module Scalarm
  module Parser
    # Scalarm::Parser::Experiment represents multiple runs of the test on different amount of processors
    # For example, this includes all runs of scaled problem of size 1_000
    class Experiment
      attr_reader :data

      def initialize(data)
        @data = order(data)
        calculate_metrics
      end

      private

      def sequential_run_entry
        @sequential_run_entry ||= data.find { |entry| entry.processors == 1 }
      end

      def calculate_metrics
        data.each { |entry| entry.calculate_metrics(sequential_run_entry) }
      end

      def order(data)
        data.sort { |left, right| left.processors <=> right.processors }
      end
    end
  end
end
