require 'spec_helper'

describe Scalarm::Experiment do
  let(:experiment) { described_class.new }
  let(:input_file_data) { {}.to_json }

  before do
    allow(File).to receive(:read).with('input.json').and_return(input_file_data)
  end

  describe '#inputs' do
    subject { experiment.inputs }
    context 'for empty input file' do
      it { is_expected.to eq({}) }
    end

    context 'for file with inputs' do
      let(:input_file_data) { { processors: 5, difficult: 'Noo.' }.to_json }
      it { is_expected.to eq(processors: 5, difficult: 'Noo.') }
    end
  end

  describe '#result' do
    subject { experiment.result }
    context 'when no outputs are assigned' do
      it { is_expected.to eq(status: :ok, results: {}) }
    end

    context 'when outputs are assigned' do
      before { experiment.fine_result = :gold }
      it { is_expected.to eq(status: :ok, results: { fine_result: :gold }) }
    end
  end

  describe '#save_result' do
    subject { output.string }

    let(:output) { StringIO.new }
    before do
      expect(File).to receive(:open).with('output.json', 'wb+').and_yield(output)
    end

    context 'when no outputs are assigned' do
      it do
        experiment.save_result
        is_expected.to eq({ status: :ok, results: {} }.to_json)
      end
    end

    context 'when outputs are assigned' do
      before { experiment.fine_result = :gold }

      it do
        experiment.save_result
        is_expected.to eq({ status: :ok, results: { fine_result: :gold } }.to_json)
      end
    end
  end
end
