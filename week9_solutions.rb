require_relative "wherever_huffman_codes_are"

class LZString < String
  def self.ascii_dictionary
    Array.new(128) { |i| [i.chr, i.chr] }.to_h
  end

  def initialize(*args)
    @dictionary = LZString.ascii_dictionary
    super(*args)
  end

  def encode!
    transform_encoding!(encoded_string)
    self
  end

  def decode!
    transform_encoding!(decoded_string)
    self
  end

  private

  def encoded_string
    encoded_string = ""
    current_chunk = ""
    each_char do |char|
      if @dictionary[current_chunk + char]
        current_chunk << char
      else
        @dictionary[current_chunk + char] = @dictionary.length
        encoded_string << @dictionary[current_chunk].chr
        current_chunk = char
      end
    end
    encoded_string << @dictionary[current_chunk].chr unless current_chunk.empty?
    encoded_string
  end

  def decoded_string
    decoded_string = self[0]
    current_chunk = self[0]
    each_char.with_index do |char, i|
      next if i == 0
      if @dictionary[char]
        next_piece = @dictionary[char]
      elsif char.ord == @dictionary.size
        next_piece = current_chunk + current_chunk[0]
      else
        raise "Fatal decoding error!"
      end

      decoded_string << next_piece
      @dictionary[@dictionary.size.chr] = current_chunk + next_piece[0]
      current_chunk = next_piece
    end
    decoded_string
  end

  def transform_encoding!(str)
    @dictionary = LZString.ascii_dictionary
    self.clear
    self.concat(str)
    @encoded = !@encoded
  end
end

# Bonus!

class SuperCode < String
  def encode!
    raise RuntimeError if @encoded
    @encoded = true
    lzw_code = LZString.new(self).encode!
    @code = HuffmanCode.new(lzw_code).encode!
    clear
    concat(@code)
  end

  def decode!
    raise RuntimeError unless @encoded
    @code.decode!
    decoded_code = LZString.new(@code).decode!
    clear
    concat(decoded_code)
  end
end
