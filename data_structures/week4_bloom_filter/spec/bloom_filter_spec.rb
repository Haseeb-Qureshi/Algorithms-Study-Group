require 'rspec'
require 'bloom_filter'
require_relative 'spec_helper/helper'

describe BloomFilter do
  subject(:bf) { BloomFilter.new(10_000, 0.001) }

  context "Bloom Filter-y stuff" do
    it "should have the correct number of bits" do
      expect(bf.num_bits).to be == 143776
    end

    it "should use the correct number of hashing functions" do
      expect(bf.hash_num).to be == 10
    end

    it "should test set membership" do
      expect(bf.include?("a")).to be false
      expect(bf.include?("b")).to be false
      bf.insert("a")
      bf.insert("b")

      expect(bf.include?("a")).to be true
      expect(bf.include?("b")).to be true

      cnt = 0
      20.times { cnt += 1 if bf.include?("ab") }
      expect(cnt).to be < 20
    end

    it "should work with any object" do
      bf.insert(:test)
      bf.insert(123)
      bf.insert({})

      expect(bf.include?(:test)).to be true
      expect(bf.include?(123)).to be true
      expect(bf.include?({})).to be true
    end

    it "should keep count of all objects inserted" do
      bf.insert("a")
      bf.insert("b")
      bf.insert("c")

      expect(bf.count).to be == 3
    end

    it "should return true/false on unique insertion success" do
      expect(bf.insert("a")).to be true
      expect(bf.insert("a")).to be false
    end

    it "should have the correct number of bits flipped after an insertion" do
      expect(bf.bits_flipped).to be == 0

      bf.insert("test")
      expect(bf.bits_flipped).to be == 10
    end

    it "should hash deterministically" do
      bf1 = BloomFilter.new(10)
      bf2 = BloomFilter.new(10)
      bf1.insert("abc")
      bf2.insert("abc")
      expect(bf1.bit_array).to be == bf2.bit_array
    end
  end

  context "extra methods" do
    it "should clear" do
      bf.insert("test")
      expect(bf.include?("test")).to be true
      bf.clear
      expect(bf.include?("test")).to be false
    end

    it "should merge correctly" do
      bf2 = BloomFilter.new(10_000)
      bf.insert(1)
      bf2.insert(2)
      bf.merge!(bf2)
      expect(bf.include?(2)).to be true
    end

    it "should throw an ArgumentError when merging some other object type" do
      sf = BloomFilter::Scalable.new(20)
      expect { bf.merge!(sf) }.to raise_error(ArgumentError)
    end

    it "should throw an ArgumentError when merging a filter that doesn't match its parameters" do
      bf2 = BloomFilter.new(20)
      expect { bf.merge!(bf2) }.to raise_error(ArgumentError)
    end
  end

  context "accuracy" do
    it "should have a roughly expected false positive rate" do
      test_size = 50_000
      expect(false_positive_rate(test_size, BloomFilter)).to be < (0.001 * 2)
    end
  end
end
