require 'rspec'
require 'huffman'

describe HuffmanNode do
  let(:node1) { HuffmanNode.new("c", 7) }
  let(:node2) { HuffmanNode.new("d", 5) }

  context "<=>" do
    it "should compare by counts" do
      expect(node1).to be > node2
    end
  end

  context "combine" do
    it "should combine into a new supernode" do
      combined = node1.combine(node2)
      expect(combined).to be_a(HuffmanNode)
      expect(combined).not_to be(node1)
      expect(combined).not_to be(node2)
    end

    it "should generate a supernode with the combined counts and letters" do
      combined = node1.combine(node2)
      expect(combined.count).to be(12)
      expect(combined.letters.sort).to eq(["c", "d"])
      expect(combined).to eq(node2.combine(node1))
    end
  end
end

describe HuffmanCode do
  context "short messages" do
    let(:syzygy) { HuffmanCode.new("syzygy") }

    it "should only use 0s and 1s in its compression" do
      syzygy.encode!
      expect(String(syzygy).chars.uniq.sort).to eq(["0", "1"])
    end

    it "should compress a message to the optimal length" do
      syzygy.encode!
      expect(String(syzygy).size).to eq(11)
    end

    it "should decode a short message correctly" do
      syzygy.encode!
      syzygy.decode!
      expect(String(syzygy)).to eq("syzygy")
    end

    it "should raise an error if trying to decode an un-encoded message" do
      expect { syzygy.decode! }.to raise_error(RuntimeError)
    end

    it "should be repeatable" do
      syzygy.encode!
      syzygy.decode!
      syzygy.encode!
      syzygy.decode!
      expect(String(syzygy)).to eq("syzygy")
    end
  end

  context "longer messages" do
    let(:silly_string)  { HuffmanCode.new("sufferinsuccotash" * 2500) }

    it "should compress a long message" do
      silly_string.encode!
      expect(String(silly_string).length).to eq(147_500)
    end

    it "should decode a long message" do
      silly_string.encode!
      silly_string.decode!
      expect(String(silly_string)).to eq("sufferinsuccotash" * 2500)
    end
  end

  context "compression factor" do
    let(:syzygy) { HuffmanCode.new("syzygy") }
    let(:dec) do
      HuffmanCode.new("When in the Course of human events, it becomes necessary for one people to dissolve the political bands which have connected them with another, and to assume among the powers of the earth, the separate and equal station to which the Laws of Nature and of Nature's God entitle them, a decent respect to the opinions of mankind requires that they should declare the causes which impel them to the separation.

      We hold these truths to be self-evident, that all men are created equal, that they are endowed by their Creator with certain unalienable Rights, that among these are Life, Liberty and the pursuit of Happiness.--That to secure these rights, Governments are instituted among Men, deriving their just powers from the consent of the governed, --That whenever any Form of Government becomes destructive of these ends, it is the Right of the People to alter or to abolish it, and to institute new Government, laying its foundation on such principles and organizing its powers in such form, as to them shall seem most likely to effect their Safety and Happiness. Prudence, indeed, will dictate that Governments long established should not be changed for light and transient causes; and accordingly all experience hath shewn, that mankind are more disposed to suffer, while evils are sufferable, than to right themselves by abolishing the forms to which they are accustomed. But when a long train of abuses and usurpations, pursuing invariably the same Object evinces a design to reduce them under absolute Despotism, it is their right, it is their duty, to throw off such Government, and to provide new Guards for their future security.--Such has been the patient sufferance of these Colonies; and such is now the necessity which constrains them to alter their former Systems of Government. The history of the present King of Great Britain is a history of repeated injuries and usurpations, all having in direct object the establishment of an absolute Tyranny over these States. To prove this, let Facts be submitted to a candid world.")
    end

    it "should output the compressed size compared to ASCII encoding (7-bits) for a short string" do
      expect(syzygy.ascii_compression_factor).to eq("26.0%")
    end

    it "should output the compressed size compared to ASCII encoding (7-bits) for a long string" do
      expect(dec.ascii_compression_factor).to eq("62.0%")
    end

    it "should output the compressed size compared to a fixed-length encoding for a short string" do
      expect(syzygy.fixed_compression_factor).to eq("92.0%")
    end

    it "should output the compressed size compared to a fixed-length encoding for a long string" do
      expect(dec.fixed_compression_factor).to eq("72.0%")
    end
  end
end
