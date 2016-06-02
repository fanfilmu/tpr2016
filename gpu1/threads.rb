require 'csv'
require 'pry'

data = CSV.parse(File.read('threads.csv'), headers: true)
grouped = data.group_by { |row| row['block_size'].to_i }

problem_sizes = data.map { |row| row['problem_size'].to_i }.uniq.sort
thread_sizes = grouped.keys.sort
csv = CSV.generate do |csv|
  csv << ['thread_count', problem_sizes].flatten

  thread_sizes.each do |thread_size|
    problem_results = grouped[thread_size]
    results = problem_sizes.map do |problem_size|
      problem_result = problem_results.select { |row| row['problem_size'].to_i == problem_size }
      times = problem_result.map { |row| row['gpu_time'].to_f }
      times.inject(0.0) { |sum, e| sum + e } / times.size
    end

    csv << [thread_size, results].flatten
  end
end

puts csv
