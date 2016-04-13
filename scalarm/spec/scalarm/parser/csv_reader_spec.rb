require 'spec_helper'

describe Scalarm::Parser::CsvReader do
  let(:fixtures_path) { File.expand_path(File.join('.', 'spec', 'fixtures')) }
  let(:data)   { File.read(File.join(fixtures_path, 'data.csv')) }
  let(:reader) { described_class.new data }

  describe '#experiments' do
    subject { reader.experiments }

    it 'creates 22 experiments' do
      expect(subject.count).to eq 22
    end
  end
end
