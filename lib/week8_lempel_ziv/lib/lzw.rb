class LZString < String
  def self.ascii_dictionary
    Array.new(128) { |i| [i.chr, i.chr] }.to_h
  end

  def initialize(*args)
    @dictionary = LZString.ascii_dictionary
    super(*args)
  end

  def encode!
    # you know what to do
  end

  def decode!
    # you may or may not know what to do
  end
end
