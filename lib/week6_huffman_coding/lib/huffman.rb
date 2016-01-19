require_relative 'heap'

class HuffmanNode
  include Comparable
  attr_reader :letters, :count

  def initialize(letters, count)
    # letters should be an array of the letter(s) this node represents
    @letters = Array(letters)
    # count should be the combined number of instances of these letter(s)
    @count = count
  end

  def <=>(other_huffman_node)
  end

  def combine(other_huffman_node)
  end

  def inspect
    "#{@letters} => #{@count}"
  end
end

class HuffmanCode < String
  attr_reader :codes
  def encode!
    fail
    # should turn this into a Huffman Code (and store the code in an ivar)
  end

  def decode!
    fail
    # should turn this back into the original message
  end

  def fixed_compression_factor
    # calculate the compression savings compared to fixed-length encoding
  end

  def ascii_compression_factor
    # calculate the compression savings compared to ASCII encoding
  end
end
