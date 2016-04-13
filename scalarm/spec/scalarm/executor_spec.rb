require 'spec_helper'

describe Scalarm::Executor do
  let(:executor) { described_class.new }

  describe '#execute' do
    subject { executor.execute(&commands) }

    context 'when commands do not require to capture outuput' do
      let(:commands) do
        proc do
          run 'ruby -e "puts \"Hi\""'
          run 'ruby -e "puts \"Seems to be working\""'
        end
      end

      let(:expected_command) do
        'ruby -e "puts \"Hi\"" > /dev/null && ruby -e "puts \"Seems to be working\"" > /dev/null'
      end

      it 'executes proper command' do
        expect(executor).to receive(:`).with(expected_command).and_return('')
        subject
      end

      it { is_expected.to eq({}) }
    end

    context 'when one of the outputs should be captured' do
      let(:commands) do
        proc do
          run 'ruby -e "puts \"Hi\""'
          capture 'ruby -e "puts \"Seems to be working\""', as: :note
        end
      end

      let(:expected_command) do
        'ruby -e "puts \"Hi\"" > /dev/null && EX_OUT1="$(ruby -e "puts \"Seems to be working\"")"; echo "note:${EX_OUT1}"'
      end

      it 'executes proper command' do
        expect(executor).to receive(:`).with(expected_command).and_return('note:Seems to be working')
        subject
      end

      it { is_expected.to eq(note: 'Seems to be working') }
    end
  end
end
