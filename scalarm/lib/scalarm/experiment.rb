require 'json'
require 'ostruct'

module Scalarm
  # Scalarm::Experiment represents a Scalarm experiment. It reads inputs from input.json,
  # allows assigning any results (like OpenStruct) and then allows saving them to output.json
  class Experiment
    attr_reader :inputs, :outputs

    def initialize
      @inputs  = read_inputs
      @outputs = OpenStruct.new
    end

    def result
      {
        status: :ok,
        results: outputs.to_h
      }
    end

    def save_result
      File.open 'output.json', 'wb+' do |f|
        f.write result.to_json
      end
    end

    def method_missing(method, *args, &block)
      outputs.send(method, *args, &block)
    end

    private

    def read_inputs
      json_data = File.read('input.json')
      JSON.parse(json_data, symbolize_names: true)
    end
  end
end
