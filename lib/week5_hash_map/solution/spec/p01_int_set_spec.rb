require 'rspec'
require 'p01_int_set'

describe MaxIntSet do
  let(:set) { MaxIntSet.new(50) }

  context "#include?" do
    it "should return false unless the number has been inserted" do
      expect(set.include?(1)).to be(false)
    end

    it "should return true if the number has been inserted" do
      set.insert(1)
      expect(set.include?(1)).to be(true)
    end
  end

  context "#insert" do
    it "should be able to insert numbers within range" do
      expect { set.insert(49) }.not_to raise_error
    end

    it "should raise an error when inserting numbers that are out of range" do
      expect{ set.insert(51) }.to raise_error("Out of bounds")
      expect{ set.insert(-1) }.to raise_error("Out of bounds")
    end
  end

  context "#remove" do
    it "should remove a number from the set" do
      set.insert(1)
      set.remove(1)
      expect(set.include?(1)).to be(false)
    end
  end
end

describe IntSet do
  let(:set) { IntSet.new(20) }

  context "#include?" do
    it "should return false unless the number has been inserted" do
      expect(set.include?(1)).to be(false)
    end

    it "should return true if the number has been inserted" do
      set.insert(1)
      expect(set.include?(1)).to be(true)
    end
  end

  context "#insert" do
    it "should be able to insert any numbers" do
      expect { set.insert(49) }.not_to raise_error
      set.insert(50)
      expect(set.include?(50)).to be(true)
    end
  end

  context "#remove" do
    it "should remove a number from the set" do
      set.insert(1)
      set.remove(1)
      expect(set.include?(1)).to be(false)
    end
  end
end

describe ResizingIntSet do
  let(:set) { ResizingIntSet.new(20) }

  context "#include?" do
    it "should return false unless the number has been inserted" do
      expect(set.include?(1)).to be(false)
    end

    it "should return true if the number has been inserted" do
      set.insert(1)
      expect(set.include?(1)).to be(true)
    end
  end

  context "#insert" do
    it "should be able to insert any numbers" do
      expect { set.insert(49) }.not_to raise_error
      set.insert(50)
      expect(set.include?(50)).to be(true)
    end
  end

  context "#remove" do
    it "should remove a number from the set" do
      set.insert(1)
      set.remove(1)
      expect(set.include?(1)).to be(false)
    end
  end

  context "#count" do
    it "should keep track of how many entries the set has" do
      expect(set.count).to eq(0)
      5.times { |i| set.insert(i) }
      expect(set.count).to eq(5)
    end
  end

  context "#resize!" do
    it "should resize when enough items are inserted" do
      i = 0
      expect(set).to receive(:resize!).exactly(1).times
      21.times { |i| set.insert(i)}
    end
  end
end
