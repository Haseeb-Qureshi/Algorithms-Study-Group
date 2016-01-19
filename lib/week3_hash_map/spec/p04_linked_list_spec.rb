require 'rspec'
require 'p04_linked_list'

describe LinkedList do
  let(:list) do
    list = LinkedList.new
    list.insert(:first, 1)
    list.insert(:second, 2)
    list.insert(:third, 3)
    list
  end

  describe "#get" do
    it "gets by key" do
      expect(list.get(:first)).to eq(1)
      expect(list.get(:second)).to eq(2)
      expect(list.get(:third)).to eq(3)
    end

    it "returns nil for absent keys" do
      expect(list.get(1)).to be_nil
    end
  end

  describe "#remove" do
    it "removes a link by key" do
      expect(list.get(:first)).to eq(1)
      list.remove(:first)
      expect(list.get(:first)).to be_nil
    end
  end

  describe "#include?" do
    it "returns true if a key is present" do
      expect(list.include?(:first)).to be true
    end

    it "returns false if a key is not in the list" do
      expect(list.include?(:fourth)).to be false
    end
  end

  describe "#each" do
    it "enumerates over the links" do
      i = 0
      vals = (1..3).to_a
      list.each do |link|
        expect(link.val).to eq(vals[i])
        i += 1
      end
    end

    it "includes Enumerable module" do
      expect(list.class.ancestors).to include(Enumerable)
    end
  end
end
