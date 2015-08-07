require 'murmurhash3'

class BloomFilter
  attr_reader :failure_rate, :capacity, :num_bits, :bit_array, :count,
              :bits_flipped, :hash_num, :random_variations

  # Here be math.
  def self.required_bits(capacity, failure_rate)
    (-(capacity * Math.log(failure_rate)).fdiv(Math.log(2) ** 2)).round
  end

  def self.required_hashes(capacity, num_bits)
    (Math.log(2) * (num_bits.fdiv(capacity))).ceil
  end

  # Now you.
  def initialize(capacity, failure_rate = 0.001)
    # the asymptotic rate of false positives
    @failure_rate = failure_rate
    # the max number of items in the filter (for which we'll guarantee the failure rate):
    @capacity = capacity
    # the required number of bits in the array:
    @num_bits # = ?
    # our bit array uses true/false instead of 0/1:
    @bit_array # = ?
    # the number of unique additions to the filter:
    @count = 0
    # the number of bits that have been flipped in our filter:
    @bits_flipped = 0
    # the number of hash functions that minimizes the probability of false positives:
    @hash_num # = ?
    # random bytes that we'll use to generate new composite hashes:
    @random_variations # = ?
  end

  def insert(key)
    # Use all of your hash functions and see if the bits at those indices
    # have been flipped. If any of them haven't, flip 'em.

    # Then return true or false and/or increment count, depending on whether
    # any bits were flipped.
    #
    # (Note: this means that whenever there's a collision, your BloomFilter's
    # count will not increase.)
  end

  def include?(key)
    # Go through all of your composite hash functions and see if any of those
    # bits are not flipped.
  end

  def clear
    # Clean out your Bloom Filter, you filthy child.
  end

  def inspect
    "Count: #{@count}\n
    Number of bits: #{@num_bits}\n
    Bits flipped: #{@bits_flipped}\n
    Number of hashes: #{@hash_num}"
  end

  def merge!(other_filter)
    # Merge together two Bloom Filters!
    #
    # Make sure that they both have the same parameters. Or else
    # all hell will break loose. Can you figure out why?
  end

  private

  # Use this hash function! Note that it only hashes other numbers.
  def hash(num)
    MurmurHash3::V32.int64_hash(num)
  end

  def hashed_index(key, i)
    # Maybe now is the time to try out that XORing and modulo trick? Hmmmmmm...
  end

  # Make sure you deterministically generate your variations. Otherwise your
  # merge isn't going to work. However, to maintain your false positive rate,
  # they also have to be pretty random. See what you can come up with.
  def generate_hash_variations
  end

  class Scalable
    SIZE_SCALE_FACTOR = 2
    FAILURE_SCALE_FACTOR = Math.log(2) ** 2
    attr_reader :bloom_filters, :failure_rate

    def initialize(initial_capacity, failure_rate = 0.001)
      @failure_rate = failure_rate
      # Here are all your Bloom Filters. Remember that they asymptotically
      # approach your failure rate by multiplying their failure rates
      # by the failure scale factor, raised to increasing powers for every subsequent
      # Bloom Filter. Remember to do this for your first Bloom Filter too.
      @bloom_filters # = ?
    end

    def count
      # Count up all your insertions.
    end

    def insert(key)
      # Insert into your current Bloom Filter. If it's full, you need to add
      # a new filter.
    end

    def include?(key)
    end

    def merge!(other_filter)
      # Merge two scalable Bloom Filters. Be sure to throw an error if the other
      # filter isn't a scalable Bloom Filter.
    end

    private

    def current_filter
    end

    def add_filter!
      # Add a new filter to your collection of Bloom Filters.
      # The new filter's capacity should be scaled by the size scale factor.
      # Its failure rate should be scaled by the failure scale factor raised to
      # (your number of filters) + 1.
    end
  end

  # For your testing pleasure. Can also be used to test Scalable Filters by
  # passing `BloomFilter::Scalable` as your third argument.
  def self.test_false_positive_rate(test_size, print_to_screen = true, type = BloomFilter)
    bf = type.new(test_size)
    (0...test_size).each { |n| bf.insert(n) }
    false_positives = (test_size...test_size * 2).inject(0) do |count, n|
      count += 1 if bf.include?(n)
      count
    end
    rate = false_positives.fdiv(test_size)

    if print_to_screen
      puts "Your Bloom Filter had a false positive rate of #{rate * 100}%.\n"\
           "Its actual rate should have been #{bf.failure_rate * 100}%."
    end
    rate
  end
end
