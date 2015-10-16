require_relative 'heap'

class HuffmanCode < String
  attr_reader :codes
  def encode!
    preprocess
    construct_code
    self
  end

  def decode!
    raise RuntimeError unless @encoded
    reconstruct_message
    self
  end

  def preprocess
    freqs = Hash.new(0)
    chars.each { |char| freqs[char] += 1 }
    @letter_frequencies = freqs.map { |char, count| HuffmanNode.new(char, count) }
    @codes = chars.map { |char| [char, ""] }.to_h
  end

  def construct_code
    nodes = Heap.new(@letter_frequencies)
    until nodes.size == 1
      min1, min2 = nodes.pop_min, nodes.pop_min
      super_node = min1.combine(min2)
      nodes.insert(super_node)
      min1.letters.each { |letter| @codes[letter].prepend("0") }
      min2.letters.each { |letter| @codes[letter].prepend("1") }
    end
    generated_code = gsub(/./) { |char| @codes[char] }
    transform_encoding!(generated_code)
  end

  def reconstruct_message
    decoded_string = ""
    current_string = ""
    inverted_codes = @codes.invert
    each_char do |char|
      current_string << char
      if inverted_codes.has_key?(current_string)
        decoded_string << inverted_codes[current_string]
        current_string.clear
      end
    end
    transform_encoding!(decoded_string)
  end

  def transform_encoding!(new_contents)
    self.clear
    self.concat(new_contents)
    @encoded = !@encoded
  end

  def fixed_compression_factor
    fixed_encoding_length = Math.log2(chars.uniq.count).ceil * length
    compression_factor = calculate_compression_factor(fixed_encoding_length)
    "#{compression_factor}%"
  end

  def ascii_compression_factor
    compression_factor = calculate_compression_factor(7 * length)
    "#{compression_factor}%"
  end

  def calculate_compression_factor(other_encoding_length)
    initial_length = length
    encode!
    huffman_encoded_length = length
    decode!
    huffman_encoded_length.fdiv(other_encoding_length).round(2) * 100
  end

  def output_compression_benchmarks
    puts "Percentage savings over fixed-length encoding: #{fixed_compression_factor}"
    puts "Percentage savings over ASCII encoding: #{ascii_compression_factor}"
  end
end

class HuffmanNode
  include Comparable
  attr_reader :letters, :count
  def initialize(letters, count)
    @letters = Array(letters)
    @count = count
  end

  def <=>(other)
    @count <=> other.count
  end

  def combine(other)
    HuffmanNode.new(@letters + other.letters, @count + other.count)
  end

  def inspect
    "#{@letters} => #{@count}"
  end
end
