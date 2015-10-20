# Week 9: Compression: The Lempel-Ziv Family
##### Led by: [Haseeb Qureshi](https://github.com/Haseeb-Qureshi/), instructor at [App Academy](http://appacademy.io)

###### Topics:
* Huffman Coding revisited
* The weakness of entropy & Huffman Codes
* LZ77: Sliding windows
* LZ78: Dictionaries
* The Lempel-Ziv Family
  * DEFLATE (LZ77 + Huffman Coding) - WinZip, Gzip
  * LZMA (LZ77 + Markov Chains) - 7zip
  * LZSS (LZ77 + Smarter Encoding & Bit flags) - WinRar, GBA BIOS
  * [LZW](https://www.cs.duke.edu/csed/curious/compression/lzw.html) (LZ78 + Adaptive Dictionary) - Unix#Compress, GIF, PNG
* TL;DR: We're gonna build GIF/PNG encoding!

### PROBLEM SET:

##### Download [this skeleton](lib/week9_lempel_ziv/skeleton.zip), bundle install, and start passing those specs!

## README

Like with Huffman Codes, we'll be creating String hybrids to perform our dirty work.

1. Start by writing your `encode!` method. Below is a general explanation of the algorithm again,
  just to give you a guidepost.

  ```
    Start with a dictionary initialized to the ASCII alphabet. Walk through the characters one by one and build up a temporary string. Each time your temporary string already appears in your dictionary, add another character to it. But if it doesn't appear in your dictionary, then add a new entry to your dictionary for that new, never-before-seen substring, shovel the encoding of the part of the substring you HAVE seen into your overall encoded string, and start building your temporary string from scratch again.

  Keep going until you reach the end of the string.
  ```

  Watch out for dangling substrings at the end.

  It may be helpful to use the below (or some variation of it) to test your implementation:

  ```ruby  
    def decode!
      @dictionary = @dictionary.invert
      gsub!(/./) { |char| @dictionary[char] }
    end
  ```

  Again, it may be useful to use the `String#clear` method.

2. Now write your `decode!` method. I'll leave this one to you, but it may be helpful to work through an easy example by hand to figure out how to do it. A good string to use is `thisisthe` (first encode it, then decode it).

  Figure out the algorithm you're using to decode, and then generalize it. This can definitely be tricky, so be careful.


### BONUS:

#### Combine LZW encoding with Huffman Coding to create your own composite compression algorithm
Use your Huffman Coding solution!

I'll let you figure out how this should be done. Should be pretty simple if you have both working! I'd recommend writing a composite class to do this work for you.
