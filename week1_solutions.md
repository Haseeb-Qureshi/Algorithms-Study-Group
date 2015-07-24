## Week 1 solutions:
1. Reverse a string (don't use `String#reverse` or `Array#reverse`). Do it by hand.
```ruby
    def reverse(str)
      length = str.length
      str.length.times do |i|
        return str if i + 1 > length.fdiv(2)
        temp = str[i]
        str[i] = str[length - i - 1]
        str[length - i - 1] = temp
      end
      str
    end

    def recursive_rev(str)
      str.length <= 1 ? str : str[-1] + recursive_rev(str[0..-2])
    end
```

2. Find the first non-repeating character in a String. (Try to do this in `O(n)` time.)

```ruby
def first_nonrepeating_char(str)
    char_counts = Hash.new(0)
    str.each_char { |char| char_counts[char] += 1 }
    char_counts.find { |char, count| count == 1 }.first
end
```

3. Given two strings, determine if the strings are anagrams. E.g., "bat" is an anagram of "tab," but not of "bate" or "at"

```ruby
def anagrams?(str1, str2) # sorting -- O(nlog(n))
    str1.chars.sort.join == str2.chars.sort.join
end

def anagrams2?(str1, str2) # no sorting -- O(n)
    return false unless str1.length == str2.length

    counts1, counts2 = Hash.new(0), Hash.new(0)
    str1.length.times do |i|
        counts1[str1[i]] += 1
        counts2[str2[i]] += 1
    end
    counts1 == counts2
end
```

4. Determine if a string is a rotation of another string. (Don't use the `Array#rotate` method.) Ex: `deabc` is a rotation of `abcde` (wrapping around by 2 to the right).


```ruby
def rotation?(str1, str2) # (O(k^2) where k is the length of the strings)
    return false if str1.length != str2.length

    str1.length.times do |i|
        return true if str1 == rotate(str2, i)
    end
    false
end

def rotate(str, deg)
    new_str = str.dup
    deg = deg % (str.length)
    str.length.times do |i|
        new_str[i] = str[(i + deg) % (str.length)]
    end
    new_str
end

def fast_rotation?(str1, str2) # deliciously clever O(n) solution
  return false if str1.length != str2.length
  !!(str2 + str2)[str1]
end
```

5. Find all of the permutations of a string. E.g., the permutations of "abc" are: "abc", "acb", "bac", "bca", "cab", "cba".


```ruby
def permutations(str) # O(n!), since there are n factorial permutations
    return [str] if str.length == 1
    perms = []
    permutations(str[1..-1]).each do |permutation|
        (permutation.length + 1).times do |position|
            perms << permutation.dup.insert(position, str[0])
        end
    end
    perms
end
```

7. Determine if, given three strings, the first two strings can be interleaved to produce the third string. An interleaving is when the characters of two strings are combined in some order to produce a third string, but with the ordering of characters maintained.

 E.g., "abc" and "def" can be interleaved to make "adbecf". However, if you took away any letter, or changed the order to "acdfeb", it would no longer be a valid interleaving.


 ```ruby
 def is_interleaved?(str1, str2, str3, cache = {})
     return false if cache[str1] || cache[str2]
     return false if str1.length + str2.length != str3.length

     if str1.length == 0 || str2.length == 0 || str3.length == 0
         return true if str1 + str2 == str3
         return false
     end

     return false if str1[0] != str3[0] && str2[0] != str3[0]

     if str1[0] == str3[0] && is_interleaved?(str1[1..-1], str2, str3[1..-1], cache)
         return true
     elsif str2[0] == str3[0] && is_interleaved?(str1, str2[1..-1], str3[1..-1], cache)
         return true
     end

     cache[str1], cache[str2] = true, true
     false

 end
 ```
