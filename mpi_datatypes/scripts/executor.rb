#!/software/local/el6/COMMON/ruby/2.2.1/bin/ruby

ENV['GEM_HOME'] = '/people/plgfan/.gems'
ENV['GEM_PATH'] = '/people/plgfan/.gems'

require 'scalarm'

$workdir = File.expand_path File.dirname __FILE__

sources = %w(src/matrix.c src/mpi_helpers.c src/mpi_datatypes.c)
sources = sources.map { |file| File.join $workdir, file }.join ' '
make = "mpicc -o #{$workdir}/mpi_datatypes #{sources} -Wall"

experiment = Scalarm::Experiment.new

processors = experiment.inputs[:processors].to_i
problem_size = experiment.inputs[:problem_size].to_i
scaled = experiment.inputs[:scaled] == 'true'

if scaled
  problem_size = processors ** (1.0 / 3) * problem_size
end

mpiexec = "mpiexec -np #{processors} #{$workdir}/mpi_datatypes #{problem_size}"

executor = Executor.new
results = executor.execute do
  run 'module load libs/boost/1.52.0'
  run make
  capture mpiexec, as: :time
end

experiment.time = results[:time]
experiment.save_result
