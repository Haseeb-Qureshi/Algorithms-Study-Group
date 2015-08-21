class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    return false if @store[num]
    @store[num] = true
  end

  def remove(num)
    raise "Out of bounds" unless is_valid?(num)
    return nil unless include?(num)
    @store[num] = false
    num
  end

  def include?(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num.between?(0, @store.length)
  end
end


class IntSet
  def initialize(length = 20)
    @store = Array.new(length) { Array.new }
  end

  def insert(num)
    return false if include?(num)
    self[num] << num
    num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % @store.length]
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(length = 20)
    @length = length
    @store = Array.new(length) { Array.new }
    @count = 0
  end

  def insert(num)
    return false if include?(num)
    self[num] << num
    @count += 1
    resize! if num_buckets < @count

    num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @length *= 2
    @count = 0
    @store = Array.new(@length) { Array.new }

    old_store.flatten.each { |num| insert(num) }
  end

  def [](num)
    @store[num % @store.length]
  end
end
