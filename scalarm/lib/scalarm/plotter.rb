require 'yaml'
require 'tempfile'

module Scalarm
  # Parser module contains classes which handle GNUPLOT integration
  class Plotter
    attr_reader :experiments

    def initialize(experiments)
      @experiments = experiments
    end

    def plot
      command = ''
      command += templates['header']

      %w(time speed_up efficiency serial_fraction).product([true, false]).each do |(metric, scaled)|
        metric_plot_command = command + templates['description'][metric][scaled]
        metric_plot_command += format templates['plot'], output: output_name(metric, scaled)

        data_file = Tempfile.new('plot-data')
        data_file.write build_plot_data_for_metric(metric, scaled: scaled)
        data_file.close

        metric_plot_command += grouped_experiments[scaled].each_with_index.map do |experiment, index|
          format templates['serie'], path: data_file.path, title: experiment.problem_size, serie: index + 2, style: index + 1
        end.join ", \\\n"

        plot_file = Tempfile.new('plot-script')
        plot_file.write metric_plot_command
        plot_file.close

        `gnuplot #{plot_file.path}`
      end
    end

    private

    def output_name(metric, scaled)
      "#{'not_' unless scaled}scaled_#{metric}.png"
    end

    def build_plot_data_for_metric(metric, scaled:)
      build_data_for_metric(metric, scaled: scaled).map do |processors, series|
        [processors, series].flatten.map(&:to_s).join(' ')
      end.join "\n"
    end

    def build_data_for_metric(metric, scaled:)
      series = grouped_experiments[scaled].size
      data = Hash.new { |h, k| h[k] = Array.new(series, 0) }

      grouped_experiments[scaled].each_with_index do |experiment, index|
        experiment.data.each do |result|
          data[result.processors][index] = result.send metric
        end
      end

      data
    end

    def grouped_experiments
      @grouped_experiments ||= begin
        groups = experiments.group_by { |experiment| experiment.scaled? }
        groups.map { |scaled, experiments| [scaled, order_experiments(experiments)] }.to_h
      end
    end

    def order_experiments(experiments)
      experiments.sort { |left, right| left.problem_size <=> right.problem_size }
    end

    def templates
      @templates ||= YAML.load_file(template_file_path)['templates']
    end

    def template_file_path
      File.join(File.dirname(__FILE__), 'templates.yml')
    end
  end
end
