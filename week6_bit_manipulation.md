# Week 6: Bit Manipulation
##### Led by: [Haseeb Qureshi](https://github.com/Haseeb-Qureshi/), instructor at [App Academy](http://appacademy.io)

######Topics:
* How computers store integers
* Fixnums vs Bignums (no floating points for now)
* The basic bitwise operators:
  * AND(`&`)
  * OR(`|`)
  * XOR(`^`)
  * NOT(`~`)
  * LSHIFT(`<<`)
  * RSHIFT(`>>`)
* How to represent negative numbers?
  * Two's complement

Ruby methods to know:
* `Fixnum#to_s(2)` => Converts into a binary string
* `0b1000` => Binary literal. This will create the number 8 (`1000` in binary)

###### Binary Warmup:
Using pencil and paper (no terminal), calculate the below values and convert them into decimal:

1. `0110 + 0110`
2. `1101 >> 0010`
3. `1101 ^ 0101`
4. `1101 ^ (~1101)`
5. `1011 & (~0 << 2)`


### PROBLEM SET:

1. Write your own version of binary XOR. Monkey-patch String class, and XOR your binary string with another binary string. (No need for type/validity checking.)

  ```ruby
  class String
    def XOR(other_binary_string)
    end
  end
  ```

2. Write your own version of binary LSHIFT (<<) for a 4-bit binary string. Your method should take in a `Fixnum`. Pad with 0s.

  ```ruby
  class String
    def LSHIFT(num)
    end
  end
  ```

3. Determine whether a number is a power of 2 without using any looping constructs. (Hint: think in terms of its binary representation and the bit operators you know.)

  ```ruby
  def power_of_two?(num)
  end
  ```

4. Swap two integers in place, without using a third temporary variable. (Ruby's parallel assignment: `x, y = y, x` doesn't count.)

  ```ruby
  def swap(x, y)
    # ...
    puts "#{x}, #{y}" # <== should be reversed from your input
  end
  ```

5. Implement two's complement for an 8-bit system. Given an 8-bit integer in binary (represented as a string), calculate its two's complement and output the appropriate binary number as a string (which would be the representation of that number's inverse). I.e., `twos_complement("00000011")` should output `"11111101"`. Feel free to use Ruby's built-in methods to accomplish this.

  ```ruby
  def twos_complement(binary_str)
  end
  ```

#### BONUS:

6. You are given two arrays: an array of positive integers, and a shuffled version of the first array, but with one element deleted. Figure out which element was deleted from the first array. (See if you can do this in `O(n)` time. Then see if you can do this in `O(1)` space. Your understanding of bit operations will help you here!)
