require 'rspec'
require 'lzw'

describe LZString do
  let(:short_str) { LZString.new("boo") }
  let(:str) { LZString.new("hihihi") }
  let(:long_str) { LZString.new("TOBEORNOTTOBEORTOBEORNOT") }
  let(:super_long_str) { LZString.new("thisisthe" * 100)}
  context "encoding" do
    it "doesn't do anything weird to a short string" do
      short_str.encode!
      chars_arr = String(short_str).chars.map(&:ord)
      expect(chars_arr).to eq([98, 111, 111])
    end

    it "correctly encodes a repetitive string" do
      str.encode!
      chars_arr = String(str).chars.map(&:ord)
      expect(chars_arr).to eq([104, 105, 128, 128])
    end

    it "encodes a longer string" do
      long_str.encode!
      chars_arr = String(long_str).chars.map(&:ord)
      expect(chars_arr).to eq([84, 79, 66, 69, 79, 82, 78, 79, 84, 128, 130, 132, 137, 131, 133, 135])
    end
  end

  context "decoding" do
    it "correctly decodes a short string" do
      str.encode!
      str.decode!
      expect(String(str)).to eq("hihihi")
    end

    it "decodes a longer string" do
      long_str.encode!
      long_str.decode!
      expect(String(long_str)).to eq("TOBEORNOTTOBEORTOBEORNOT")
    end

    it "decodes a super long string" do
      super_long_str.encode!
      super_long_str.decode!
      expect(String(super_long_str)).to eq("thisisthe" * 100)
    end
  end
end
