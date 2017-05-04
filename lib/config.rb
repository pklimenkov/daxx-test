# Class for accessing yaml configs
class Config
  attr_reader :config
  CONFIG_DIRECTORY = File.join(File.expand_path(File.dirname(__FILE__)), '..', 'config')

  def initialize
    @config = {}
    load
  end

  def [](key)
    @config[key]
  end

  def config_directory
    CONFIG_DIRECTORY
  end

  private

  def load
    Dir[File.join(config_directory, '**', '*.yml')].each do |fp|
      name = fp[%r{(?<=\/)[\w_\d\-\.]+?(?=\.yml\Z)}i]
      @config[name.to_sym] = YAML.load_file(fp)
    end
  end
end
