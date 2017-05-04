require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

RSpec.describe Speller do
  let(:test_data_dir) { File.join(File.expand_path(File.dirname(__FILE__)), '..', 'data') }
  let(:test_config_dir) { File.join(File.expand_path(File.dirname(__FILE__)), '..', 'config') }

  it 'loads all configs from directory' do
    allow_any_instance_of(described_class).to receive(:data_directory).and_return(test_data_dir)
    expect(described_class.new.data).to eq(%w[AA AAH AARDVARK AARDVARKS AARDWOLF AARDWOLVES AARGH])
  end

  it 'if can converts number to word' do
    allow_any_instance_of(described_class).to receive(:data_directory).and_return(test_data_dir)
    allow_any_instance_of(described_class).to receive(:min_chunk).and_return(3)
    allow_any_instance_of(described_class).to receive(:max_chunk).and_return(10)
    allow_any_instance_of(Config).to receive(:config_directory).and_return(test_config_dir)
    expect(described_class.new.convert('22')).to eq(%w[AA])
  end

  it 'if cant returns empty array' do
    allow_any_instance_of(described_class).to receive(:data_directory).and_return(test_data_dir)
    allow_any_instance_of(described_class).to receive(:min_chunk).and_return(3)
    allow_any_instance_of(described_class).to receive(:max_chunk).and_return(10)
    allow_any_instance_of(Config).to receive(:config_directory).and_return(test_config_dir)
    expect(described_class.new.convert('22344456')).to eq(%w[])
  end

  it 'raises error if receives non digit input' do
    allow_any_instance_of(described_class).to receive(:data_directory).and_return(test_data_dir)
    allow_any_instance_of(described_class).to receive(:min_chunk).and_return(3)
    allow_any_instance_of(described_class).to receive(:max_chunk).and_return(10)
    allow_any_instance_of(Config).to receive(:config_directory).and_return(test_config_dir)
    expect(-> { described_class.new.convert('22344dfr456') }).to raise_error(/wrong input! must be only digits/)
  end
end
