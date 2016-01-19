require 'bloom_filter'
require_relative 'spec_helper/helper'

describe BloomFilter::Scalable do
  subject(:sf) { BloomFilter::Scalable.new(2, 0.001) }

  context "Scaling up the Bloom Filter" do
    it "should start with only one filter" do
      expect(sf.bloom_filters.size).to be == 1
    end

    it "should add another Bloom Filter when it reaches capacity" do
      sf.insert("a")
      sf.insert("b")
      expect(sf.bloom_filters.size).to be == 1
      sf.insert("c")
      expect(sf.bloom_filters.size).to be == 2
    end

    it "should still correctly test set membership" do
      expect(sf.include?("a")).to be false
      expect(sf.include?("b")).to be false
      sf.insert("a")
      sf.insert("b")

      expect(sf.include?("a")).to be true
      expect(sf.include?("b")).to be true

      cnt = 0
      20.times { cnt += 1 if sf.include?("ab") }
      expect(cnt).to be < 20
    end

    it "should work with any object" do
      sf.insert(:test)
      sf.insert(123)
      sf.insert({})

      expect(sf.include?(:test)).to be true
      expect(sf.include?(123)).to be true
      expect(sf.include?({})).to be true
    end

    it "should keep count of all objects inserted" do
      sf.insert("a")
      sf.insert("b")
      sf.insert("c")

      expect(sf.count).to be == 3
    end
  end

  context "extra methods" do
    it "should merge correctly" do
      sf2 = BloomFilter::Scalable.new(3)
      sf.insert(1)
      sf2.insert(2)
      sf.merge!(sf2)
      expect(sf.include?(2)).to be true
    end

    it "should throw an ArgumentError unless merging another scalable filter" do
      bf = BloomFilter.new(20)
      expect { sf.merge!(bf) }.to raise_error(ArgumentError)
    end
  end

  context "accuracy" do
    it "should have a roughly expected false positive rate" do
      test_size = 50_000
      expect(false_positive_rate(test_size, BloomFilter::Scalable)).to be < (0.001 * 10)
    end
  end
end
