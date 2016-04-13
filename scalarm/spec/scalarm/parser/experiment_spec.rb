require 'spec_helper'

describe Scalarm::Parser::Experiment do
  let(:experiment) { described_class.new experiments }

  context 'when given set of results' do
    let(:experiments) do
      Array.new(5) do |i|
        build(:result, scaled: 'false', processors: (i + 1).to_s, time: (60 / (i + 1)).to_s, problem_size: '100')
      end
    end

    it 'calculates metrics for each entry' do
      experiment.data.each do |experiment|
        expect(experiment.speed_up).to eq experiment.processors
        expect(experiment.efficiency).to eq 1.0
        expect(experiment.serial_fraction).to eq 0.0
      end
    end
  end
end
