# Week 8: Huffman Coding
##### Led by: [Haseeb Qureshi](https://github.com/Haseeb-Qureshi/), instructor at [App Academy](http://appacademy.io)

###### Topics:
* Why compress stuff? How does one compress anything?
* Run-length encoding
* Entropy: Claude Shannon is basically the man
* Fixed-length encoding (and why it kinda sucks)
* Variable-length encoding
* The story of Claude Shannon & David Huffman
* Huffman Coding through binary trees
* Prefix-free codes
* Reconstructing the string
* Weaknesses of Huffman Coding in isolation?

### PROBLEM SET:

##### Download [this skeleton](lib/week8_huffman_coding/skeleton.zip), bundle install, and start passing those specs!

## README

1. Start by writing the Huffman Nodes. You will use these as you construct your codes. (You don't actually need to construct a binary tree at any point, that's just to help visualize how the codes work. You'll be fine using arrays/hashes/heaps.) These nodes are just so you can represent the supernodes in some way and make comparisons among them.

  The specs should be self-explanatory.

2. Now start writing your Huffman Code method. It inherits from `String`, so you have access to all the `String` methods.

  `encode!` should start by calculating all of the frequencies of each letter in the string. Put all those frequencies in some data structure (you can use a heap or an array if you want). Repeatedly combine the smallest two nodes into a supernode. Assign each of those two nodes an extra bit in their encodings (`0` and `1`), and keep running that loop until there's only one supernode left. That means it's all converged to one tree, and your Huffman Code has been generated.

  Now transform your string, character-by-character, into its Huffman-coded version.

  Methods that may be helpful:
  * `String#clear`: replaces the string's contents with `""`
  * `String#gsub!(&blk)`: replaces the string's contents that match a Regex (or string) with the value provided in the block
  * `Hash#invert`: flips the keys and values in a hash

3. Now to `decode!` This turns the message from the encoded version back into the original message. This shouldn't be too hard; just make sure you saved the Huffman Code you generated before in an instance variable.

  If your code is prefix-free (in other words, if you did it correctly), you should be able to unambiguously reconstruct the original string.


### BONUS:
#### Calculate your compression savings!

`ascii_compression_factor`: this method calculates your savings relative to encoding the string into ASCII. ASCII is a fixed-length encoding, where each character takes 7-bits. You should be able to manage this math.

`fixed_compression_factor`: this method calculates your savings relative to an ideal fixed-length encoding. Think about a way to write this up in code. If you had to assign every character in the string a code, and all of the codes were the same length, how long would each code have to be?
