#!/software/local/el6/COMMON/ruby/2.2.1/bin/ruby

require 'logger'
require 'fileutils'
require 'json'

$workdir = File.expand_path File.dirname __FILE__
$logdir  = File.expand_path "~/logs"
FileUtils.mkdir_p $logdir unless Dir.exist? $logdir

def logger
  @logger ||= begin
    path = format('%s/executor.log', $logdir)
    Logger.new(path).tap { |logger| logger.level = Logger::DEBUG }
  end
end

class ModuleLoader
  def with_loaded_module(module_name)
    [format(template, module_name), yield].join(' && ')
  end

  def load_modules(*module_names)
    module_names.each { |module_name| load_module module_name }
  end

  def load_module(module_name)
    execute format(template, module_name)
  end

  private

  def template
    @template ||= "module load %s > #{$logdir}/module.log 2>&1"
  end
end

class Experiment
  attr_reader :min_processors, :max_processors, :problem_size, :scalable

  def initialize(params)
    @min_processors = params[:min_processors].to_i
    @max_processors = params[:max_processors].to_i
    @problem_size   = params[:problem_size].to_i
    @scalable       = params[:scalable] == 'true'

    logger.debug format('Loaded parameters: %s', to_h.to_s)
  end

  def scalable?
    scalable
  end

  def problems
    (min_processors..max_processors).each do |processors|
      yield processors, scalable? ? processors * problem_size : problem_size
    end
  end

  def to_h
    {
      min_processors: min_processors,
      max_processors: max_processors,
      problem_size: problem_size,
      scalable?: scalable?
    }
  end
end

def params
  @params ||= begin
    json_data = File.read('input.json')
    JSON.parse(json_data, symbolize_names: true).tap do |loaded_params|
      logger.debug format('Loaded parameters: %s', loaded_params.to_s)
    end
  end
end

def execute(command)
  command = ModuleLoader.new.with_loaded_module('libs/boost/1.52.0') { command }
  logger.debug format('Executing: %s', command)
  `#{command}`
end

def make
  files = %w(src/pi_mc.c src/mpi_helpers.c)
  sources = files.map { |file| File.join $workdir, file }.join ' '
  execute "mpicc -o #{$workdir}/pi_mc #{sources} -Wall"
end

def run(experiment)
  [].tap do |results|
    experiment.problems do |processors, problem_size|
      time = execute "mpiexec -np #{processors} #{$workdir}/pi_mc #{problem_size}"
      logger.debug format('time measured: %s', time)
      results << [processors, time.chop.to_f, problem_size]
    end
  end
end

def generate_metrics(raw_data, experiment)
  one_core_time = raw_data.find { |data| data[0] == 1 }[1]
  speedup = raw_data.map do |(cores, time, _)|
    [cores, one_core_time / time * (experiment.scalable? ? cores : 1)]
  end

  efficiency = speedup.map do |(cores, speedup)|
    [cores, speedup / cores]
  end

  serial_fraction = speedup.map do |(cores, speedup)|
    [cores, cores == 1 ? 0 : (1 / speedup - 1 / cores) / (1 - 1 / cores)]
  end

  { speedup: speedup, efficiency: efficiency, serial_fraction: serial_fraction }
end

logger.debug format('Starting at %s', Time.now)

ModuleLoader.new.load_module 'libs/boost/1.52.0'
logger.debug 'modules loaded'

logger.debug 'compiling source...'
make
logger.debug 'compiled'

experiment = Experiment.new(params)

result = {
  status: :ok,
  results: {
    raw: run(experiment)
  }
}

result[:results].merge! generate_metrics(result[:results][:raw], experiment)

logger.debug result.to_json

File.open 'output.json', 'wb+' do |f|
  f.write result.to_json
end
