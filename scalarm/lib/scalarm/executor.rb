module Scalarm
  # Helper class for defining commands needed to be executed in order to run tested program
  #
  # Example usage:
  # mpiexec = "mpiexec -np #{processors} #{$workdir}/pi_mc #{problem_size}"
  # results = executor.execute do
  #   run 'module load libs/boost/1.52.0'
  #   run make
  #   capture mpiexec, as: :time
  # end
  #
  # This will run one command which will load module libs/boost/1.52.0, make project and then capture
  # output (STDOUT) of mpiexec command to returned hash under :time key.
  # results == { time: "0.2131" }
  #   => true
  class Executor
    attr_reader :variable_map, :commands

    def initialize
      @variable_map = {}
      @commands = []
    end

    def execute(&block)
      instance_eval(&block)
      command = commands.join(' && ')
      capture_commands = print_captures.join(' && ')
      command += "; #{capture_commands}" if capture_commands != ''

      parse_captures `#{command}`
    end

    def run(command)
      commands.push "#{command} > /dev/null"
    end

    def capture(command, as:)
      commands.push "#{add_variable(as: as)}=\"$(#{command})\""
    end

    private

    def print_captures
      [].tap do |result|
        variable_map.each_pair do |variable, name|
          result << "echo \"#{name}:${#{variable}}\""
        end
      end
    end

    def parse_captures(captures)
      indexes = variable_map.values.map { |v| [captures.index("#{v}:"), v] }.sort
      indexes.push [captures.size, nil]

      indexes.each_cons(2).map do |((min, name), (max, _))|
        [name, captures[min...max].gsub("#{name}:", '').chop]
      end.to_h
    end

    def add_variable(as:)
      next_variable.tap do |variable|
        @variable_map[variable] = as
      end
    end

    def next_variable
      "EX_OUT#{variable_map.size + 1}"
    end
  end
end
