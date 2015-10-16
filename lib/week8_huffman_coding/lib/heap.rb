# This is an auxiliary data structure that you can use to speed up your code.
# http://www.cs.cmu.edu/~adamchik/15-121/lectures/Binary%20Heaps/heaps.html
class Heap
  def initialize(vals = [])
    @store = []
    vals.each { |val| insert(val) }
  end

  def size
    @store.size
  end

  alias_method :count, :size
  alias_method :length, :size

  def min
    @store[0]
  end

  def insert(val)
    @store << val
    heapify_up!
    val
  end

  alias_method :<<, :insert
  alias_method :push, :insert

  def pop_min
    min = @store.first
    if @store.length > 1
      @store[0] = @store.delete_at(@store.length - 1)
    else
      @store.delete_at(0)
    end
    heapify_down!
    min
  end

  alias_method :pop, :pop_min

  private

  def heapify_up!
    current_idx = @store.length - 1
    while current_idx > 0
      if @store[current_idx] < @store[parent_idx(current_idx)]
        swap(current_idx, parent_idx(current_idx))
      else
        break
      end
      current_idx = parent_idx(current_idx)
    end
  end

  def heapify_down!
    current_idx = 0
    while current_idx < @store.length - 1
      child1, child2 = children_idx(current_idx)
      break unless @store[child1]

      if @store[child2]
        children_vals = [[child1, @store[child1]], [child2, @store[child2]]]
        smallest_child = children_vals.min_by(&:last).first
      else
        smallest_child = child1
      end

      if @store[smallest_child] < @store[current_idx]
        swap(current_idx, smallest_child)
        current_idx = smallest_child
      else
        break
      end
    end
  end

  def parent_idx(i)
    (i - 1) / 2
  end

  def children_idx(i)
    [(2 * i) + 1, (2 * i) + 2]
  end

  def swap(i1, i2)
    @store[i1], @store[i2] = @store[i2], @store[i1]
  end
end
