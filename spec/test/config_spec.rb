require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

RSpec.describe Config do
  let(:test_config_dir) { File.join(File.expand_path(File.dirname(__FILE__)), '..', 'config') }

  it 'loads all configs from directory' do
    allow_any_instance_of(described_class).to receive(:config_directory).and_return(test_config_dir)
    expect(described_class.new.config.keys).to eq(%i[digits test_config1 test_config2])
  end

  it 'test_configs can be accesable through []' do
    allow_any_instance_of(described_class).to receive(:config_directory).and_return(test_config_dir)
    expect(described_class.new[:test_config1]).to eq(%w[test1 test2 test3])
  end
end
