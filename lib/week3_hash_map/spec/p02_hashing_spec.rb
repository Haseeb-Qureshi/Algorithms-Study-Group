require 'rspec'
require 'p02_hashing'

describe "Hashing" do
  context Array do
    it "should hash deterministically" do
      a = [1, 2, 3]
      expect(a.hash).to eq(a.hash)
    end

    it "should produce the same hash for two equivalent arrays" do
      a = [1, 2, 3]
      b = [1, 2, 3]
      expect(a.hash).to eq(b.hash)
    end

    it "should produce different values for different orderings of an array" do
      a = (1..100).to_a
      expect(a.hash).not_to eq(a.shuffle.hash)
    end

    it "should produce different values for subarrays" do
      a = [1, 2, 3]
      b = [1, 2, 3, 4]
      expect(a.hash).not_to eq(b.hash)
    end
  end

  context String do
    it "should hash deterministically" do
      a = "string"
      expect(a.hash).to eq(a.hash)
    end

    it "should produce the same hash for two identical strings" do
      a = "string"
      b = "string"
      expect(a.hash).to eq(b.hash)
    end

    it "should produce different values for different permutations of a string" do
      a = ("a".."z").to_a * 3
      b = a.shuffle
      expect(a.join.hash).not_to eq(b.join.hash)
    end

    it "should produce different values for subarrays" do
      a = "string"
      b = "substring"
      expect(a.hash).not_to eq(b.hash)
    end
  end

  context Hash do
    it "should hash deterministically" do
      a = {a: "a", b: "b"}
      expect(a.hash).to eq(a.hash)
    end

    it "should produce the same hash for two identical hashes" do
      a = {a: "a", b: "b"}
      b = {a: "a", b: "b"}
      expect(a.hash).to eq(b.hash)
    end

    it "should produce the same value for a reordering of the same hash" do
      a = {a: "a", b: "b"}
      b = {b: "b", a: "a"}
      expect(a.hash).to eq(b.hash)
    end

    it "subsets of hashes should hash to different values" do
      a = {a: "a"}
      b = {a: "a", b: "b"}
      expect(a.hash).not_to eq(b.hash)
    end
  end
end
