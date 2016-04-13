require 'csv'

module Scalarm
  module Parser
    # Scalarm::Parser::CsvReader reads data from CSV to create experiments
    class CsvReader
      attr_reader :data, :results, :create_experiments

      def initialize(data)
        @data = CSV.parse data, headers: true
      end

      def experiments
        @experiments ||= begin
          extract_results
          create_experiments
        end
      end

      private

      def create_experiments
        grouped_results.map { |_, entries| Experiment.new(entries) }
      end

      def grouped_results
        results.group_by { |result| [result.scaled?, result.problem_size] }
      end

      def extract_results
        @results = data.map { |entry| Result.new symbolize_keys(entry.to_h) }
      end

      def symbolize_keys(hash)
        hash.map { |k, v| [k.to_sym, v] }.to_h
      end
    end
  end
end
