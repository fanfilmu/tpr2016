#!/usr/bin/env ruby
require 'csv'
require 'pry'

data = CSV.parse File.read(ARGV[0]), headers: true

experiments = data.group_by { |row| [row['scalable'], row['problem_size']] }

def calculate_speed_up(one_core_entry, entry)
  one_core_entry['time'].to_f / entry['time'].to_f * (entry['scalable'] == 'true' ? entry['processors'].to_i : 1)
end

def calculate_serial_fraction(entry)
  processors = entry['processors'].to_i

  processors == 1 ? 0 : (1 / entry['speed_up'] - 1.0 / processors) / (1 - 1.0 / processors)
end

experiments.each do |_, experiment_data|
  one_core_entry = experiment_data.find { |row| row['processors'] == '1' }

  experiment_data.each do |entry|
    entry['speed_up']   = calculate_speed_up one_core_entry, entry
    entry['efficiency'] = entry['speed_up'] / entry['processors'].to_i
    entry['serial_fraction'] = calculate_serial_fraction entry
  end
end

require 'pry'

data.group_by { |row| [row['scalable'], row['problem_size']] }

plot_data = {}

data.group_by { |row| row['scalable'] }.each do |scaled, entries|
  plot_data[scaled] = {}

  entries.sort { |l, r| l['processors'].to_i <=> r['processors'].to_i }.group_by { |row| row['processors'] }.each do |x, y_entries|
    %w(time speed_up efficiency serial_fraction).each do |metric|
      ys = y_entries.sort { |l, r| l['problem_size'].to_i <=> r['problem_size'].to_i  }.map { |e| e[metric] }
      row = [x].concat(ys).join ' '
      plot_data[scaled][metric] ||= []
      plot_data[scaled][metric].push row
    end
  end
end

plot_data.each do |scaled, metrics|
  name = scaled == 'true' ? 'scaled_' : 'not_scaled_'

  metrics.each do |metric, values|
    filename = name + metric + '.dat'

    File.open File.join('results', filename), 'wb+' do |f|
      f.write values.join("\n")
    end
  end
end
