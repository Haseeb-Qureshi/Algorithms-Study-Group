class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
  end

  def remove(num)
  end

  def include?(num)
  end
end


class IntSet
  def initialize(length = 20)
    @store = Array.new(length) { Array.new }
  end

  def insert(num)
  end

  def remove(num)
  end

  def include?(num)
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(length = 20)
  end

  def insert(num)
  end

  def remove(num)
  end

  def include?(num)
  end

  private

  def resize!
  end
end
