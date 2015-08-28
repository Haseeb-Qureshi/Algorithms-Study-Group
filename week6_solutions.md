###### Warmup Solutions

1. `0110 + 0110` = `1100` = **12**
2. `1101 >> 0010` = `0011` = **3**
3. `1101 ^ 0101` = `1000` = **8**
4. `1101 ^ (~1101)` = `1111` = **15**
5. `1011 & (~0 << 2)` = `1000` = **8**

#### Problem Set Solutions

1. Write your own version of binary XOR. Monkey-patch String class, and XOR your 4-bit binary string with another 4-bit binary string. (No need for type/validity checking.)
```ruby
    class String
      def XOR(other_str)
        chars.map.with_index do |char, i|
        char == other_str[i] ? "0" : "1"
      end.join
    end
```
2. Write your own version of binary LSHIFT (<<) for a 4-bit binary string. Your method should take in a `Fixnum`. Pad with 0s.

  ```ruby
  class String
    def LSHIFT(num)
      return "0000" if num >= 4
      str = self.dup
      num.times { str << "0" }
      str[-4..-1]
    end
  end
  ```

3. Determine whether a number is a power of 2 without using any looping constructs. (Hint: think in terms of its binary representation and the bit operators you know.)

  ```ruby
  def power_of_two?(num)
    num > 0 && num & (num - 1) == 0
  end
  ```

4. Swap two integers in place, without using a third temporary variable. (Ruby's parallel assignment: `x, y = y, x` doesn't count.)

  ```ruby
  def swap1(x, y)
    x = y - x
    y = y - x
    x = x + y
    puts "#{x}, #{y}"
  end

  def swap2(x, y)
    x = x ^ y
    y = x ^ y
    x = x ^ y
    puts "#{x}, #{y}"
  end
  ```

5. Implement two's complement for an 8-bit system. Given an 8-bit integer in binary (represented as a string), calculate its two's complement and output the appropriate binary number as a string (which would be the representation of that number's inverse). I.e., `twos_complement("00000011")` should output `"11111101"`. Feel free to use Ruby's built-in methods to accomplish this.

  ```ruby
  def twos_complement(binary_str)
    complement = ""
    mirror = ~binary_str.to_i(2) + 1
    mirror.to_s(2).length.downto(0) { |n| complement << mirror[n].to_s }
    pad_num = binary_str.to_i(2) < 0 ? "0" : "1"
    (binary_num_string.length - complement.length).times { complement.insert(0, pad_num) }
  
    complement
  end
  ```

6. You are given two arrays: an array of positive integers, and a shuffled version of the first array, but with one element deleted. Figure out which element was deleted from the first array. (See if you can do this in `O(n)` time. Then see if you can do this in `O(1)` space. Your understanding of bit operations will help you here!)

```ruby
def find_duplicate(arr1, arr2)
  num = 0
  [arr1, arr2].each do |arr|
    arr.each do |el|
      num = num ^ el
    end
  end
  num
end

# hideous one-liner
def find_missing(arr1, arr2)
  [arr1, arr2].inject(0) { |num, arr| arr.each { |el| num = num ^ el }; num }
end
```
