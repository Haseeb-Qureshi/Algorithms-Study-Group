require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count
  def initialize(size = 8)
    @store = Array.new(size) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key.hash).include?(key)
  end

  def set(key, val)
    remove(key) if include?(key)
    resize! if @count > length

    @count += 1
    bucket(key.hash).insert(key, val)
  end

  def get(key)
    bucket(key.hash).get(key)
  end

  def delete(key)
    removal = bucket(key.hash).remove(key)
    @count -= 1 if removal
    removal
  end

  def [](key)
    get(key)
  end

  def []=(key, val)
    set(key, val)
  end

  def each
    @store.each do |bucket|
      bucket.each { |link| yield [link.key, link.val] }
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k} => #{v}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  private

  def length
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(length * 2) { LinkedList.new }
    @count = 0

    old_store.each do |bucket|
      bucket.each { |link| set(link.key, link.val) }
    end
  end

  def bucket(num)
    @store[num % length]
  end
end
