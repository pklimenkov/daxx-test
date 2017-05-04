# Class to spell digits through letters associated
class Speller
  attr_reader :config, :data
  DATA_DIRECTORY = File.join(File.expand_path(File.dirname(__FILE__)), '..', 'data')

  def initialize
    @config = Config.new
    load
  end

  def data_directory
    DATA_DIRECTORY
  end

  def convert(numbers)
    regex = transform(validate(numbers.to_s))
    @data.select { |word| word =~ /#{regex}/ }
  end

  private

  def load
    @data = []
    Dir[File.join(data_directory, '**', '*.txt')].each do |fp|
      @data += File.open(fp).read.split("\n")
    end
    @data.uniq!
  end

  def transform(numbers)
    regex = ''
    numbers.split('').each do |digit|
      chars = Speller.new.config[:digits][digit.to_i].map { |char| "#{char.upcase}#{char.downcase}" }.join('')
      regex << "[#{chars}]{1}"
    end
    "^#{regex}$"
  end

  def validate(numbers)
    raise 'wrong input! must be only digits' if numbers != numbers.scan(/\d/).join('')
    numbers
  end
end
