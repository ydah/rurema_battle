# frozen_string_literal: true

describe RuremaBattle do
  describe '.run' do
    subject { described_class.run(class_name: class_name, version: version) }

    let(:class_name) { 'String' }
    let(:version) { '3.0' }

    it 'calls new and run' do
      expect(described_class).to receive(:new).with(version: version, class_name: class_name).and_call_original
      expect_any_instance_of(described_class).to receive(:run).and_call_original
      subject
    end
  end

  describe '#run' do
    subject { described_class.new(version: version, class_name: class_name).run }

    let(:class_name) { 'String' }
    let(:version) { '3.0' }

    it 'calls Net::HTTP.get_response' do
      expect(Net::HTTP).to receive(:get_response).and_call_original
      subject
    end

    context 'when response is Net::HTTPSuccess' do
      it 'calls Artii::Base.new' do
        expect(Artii::Base).to receive(:new).and_call_original
        subject
      end

      it 'calls Artii::Base#asciify' do
        expect_any_instance_of(Artii::Base).to receive(:asciify).and_call_original
        subject
      end
    end

    context 'when response is not Net::HTTPSuccess' do
      before do
        allow(Net::HTTP).to receive(:get_response).and_return(double(Net::HTTPServerError, code: '500', message: 'Internal Server Error'))
      end

      it 'raises an error' do
        expect { subject }.to raise_error('500 Internal Server Error')
      end
    end
  end

  describe '#url' do
    subject { described_class.new(version: version, class_name: class_name).send(:url) }

    let(:class_name) { 'String' }
    let(:version) { '3.0' }

    it 'returns URI' do
      expect(subject).to eq(URI.parse("https://docs.ruby-lang.org/ja/#{version}/class/#{class_name}.html"))
    end
  end
end
