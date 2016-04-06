#!/software/local/el6/COMMON/ruby/2.2.1/bin/ruby

Dir[File.expand_path('~/scalarm_scripts/**')].each do |script|
  load script
end

$workdir = File.expand_path File.dirname __FILE__

sources = %w(src/pi_mc.c src/mpi_helpers.c)
sources = sources.map { |file| File.join $workdir, file }.join ' '
make = "mpicc -o #{$workdir}/pi_mc #{sources} -Wall"

experiment = ScalarmExperiment.new

processors = experiment.processors.to_i
problem_size = experiment.problem_size.to_i
problem_size *= processors if experiment.scalable == 'true'

mpiexec = "mpiexec -np #{processors} #{$workdir}/pi_mc #{problem_size}"

executor = Executor.new
results = executor.execute do
  run 'module load libs/boost/1.52.0'
  run make
  capture mpiexec, as: :time
end

experiment.time = results[:time]
experiment.save_result
