module Scalarm
  module Parser
    # Scalarm::Parser::Result represents single run of the test
    class Result
      attr_reader :result_data, :speed_up, :efficiency, :serial_fraction

      def initialize(result_data)
        @result_data = result_data
      end

      def processors
        @processors ||= result_data[:processors].to_i
      end

      def problem_size
        @problem_size ||= result_data[:problem_size].to_i
      end

      def scaled?
        @scaled ||= result_data[:scaled] == 'true'
      end

      def time
        @time ||= result_data[:time].to_f
      end

      def calculate_metrics(sequential_run_result)
        @speed_up = calculate_speed_up(sequential_run_result)
        @efficiency = calculate_efficiency
        @serial_fraction = calculate_serial_fraction
      end

      private

      def calculate_speed_up(sequential_run_result)
        sequential_run_result.time / time * (scaled? ? processors : 1)
      end

      def calculate_efficiency
        speed_up / processors
      end

      def calculate_serial_fraction
        if processors == 1
          0
        else
          (1 / speed_up - 1.0 / processors) / (1 - 1.0 / processors)
        end
      end
    end
  end
end
