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
    regexes = transform(validate(numbers.to_s))
    find_matches(regexes)
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
    regex_ary = []
    numbers.split('').each do |digit|
      chars = @config[:digits][digit.to_i].map { |char| "#{char.upcase}#{char.downcase}" }.join('')
      regex_ary << "[#{chars}]{1}"
    end

    chunks = chunk(regex_ary)
    chunks.map { |ch| ch.map { |regex| "^#{regex.join('')}$" } }
  end

  def validate(numbers)
    raise 'wrong input! must be only digits' if numbers != numbers.scan(/\d/).join('')
    numbers
  end

  def chunk(array)
    result = [[array]]
    (@config[:breakdown]['min_length']..@config[:breakdown]['max_length']).each do |size|
      slices = array.each_slice(size).to_a
      if slices.last.size < size && slices.size > 1
        last_elem = slices.pop
        slices.last.concat(last_elem)
      end
      result << slices if slices.first != array
    end
    result
  end

  def find_matches(array)
    result = []
    array.each do |words_ary|
      found = {}
      words_ary.each_with_index do |word_regex, index|
        found[index] = @data.select { |word| word =~ /#{word_regex}/ }
        puts "........ Found matches: #{found[index].size}"
      end
      data = found.values
      next if data.any? { |value| value.empty? }

      result.concat(
        data.first.product(*data[1..-1]).map { |elems| elems.join('-') }
      )
    end
    result
  end
end
