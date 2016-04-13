require 'spec_helper'

describe Scalarm::Parser::Result do
  describe 'given example result' do
    let(:result) { build(:result) }

    describe '#processors' do
      subject { result.processors }
      it { is_expected.to eq 7 }
    end

    describe '#problem_size' do
      subject { result.problem_size }
      it { is_expected.to eq 1200 }
    end

    describe '#scaled?' do
      subject { result.scaled? }
      it { is_expected.to eq true }
    end

    describe '#time' do
      subject { result.time }
      it { is_expected.to eq 0.2132 }
    end
  end

  describe 'metrics' do
    context 'for scaled problem' do
      let(:sequential_result) { build(:result, processors: '1', problem_size: '1000', time: '2.0') }
      let(:result) { build(:result, processors: '2', problem_size: '1000', time: '2.0') }

      before { result.calculate_metrics(sequential_result) }

      describe '#speed_up' do
        subject { result.speed_up }
        it { is_expected.to eq 2.0 }
      end

      describe '#efficiency' do
        subject { result.efficiency }
        it { is_expected.to eq 1.0 }
      end

      describe '#serial_fraction' do
        subject { result.serial_fraction }
        it { is_expected.to eq 0.0 }
      end
    end

    context 'for not scaled problem' do
      let(:sequential_result) { build(:result, processors: '1', problem_size: '1000', scaled: 'false', time: '2.0') }
      let(:result) { build(:result, processors: '2', problem_size: '1000', scaled: 'false', time: '1.0') }

      before { result.calculate_metrics(sequential_result) }

      describe '#speed_up' do
        subject { result.speed_up }
        it { is_expected.to eq 2.0 }
      end

      describe '#efficiency' do
        subject { result.efficiency }
        it { is_expected.to eq 1.0 }
      end

      describe '#serial_fraction' do
        subject { result.serial_fraction }
        it { is_expected.to eq 0.0 }
      end
    end
  end
end
