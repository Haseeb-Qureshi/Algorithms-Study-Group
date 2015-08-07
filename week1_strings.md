# Week 1: Strings
##### Led by: [Haseeb Qureshi](https://github.com/Haseeb-Qureshi/), instructor at (App Academy)[http://appacademy.io]

######Topics:
* What are strings?
* Think about them as special cases of arrays!
* How do they work in C? -- Null terminated, linear length lookup
* String Buffers (Ruby implementation)
* Mutability vs immutability
* String concatenation
* ASCII characters vs UTF-8 (Variable-length encoding)

### PROBLEM SET:

1. Reverse a string (don't use `String#reverse` or `Array#reverse`). Do it by hand.

    `def reverse(str)`

2. Find the first non-repeating character in a String. (Try to do this in `O(n)` time.)

    `def first_nonrepeating_char(str)`

3. Given two strings, determine if the strings are anagrams. E.g., "bat" is an anagram of "tab," but not of "bate" or "at"

    `def anagrams?(str1, str2)`

4. Determine if a string is a rotation of another string. (Don't use the `Array#rotate` method.) Ex: `deabc` is a rotation of `abcde` (wrapping around by 2 to the right).

    `def rotation?(str1, str2)`

5. Find all of the permutations of a string. E.g., the permutations of "abc" are: "abc", "acb", "bac", "bca", "cab", "cba".

    `def permutations(str)`

6. If you reversed a string iteratively, do it recursively. If you did it recursively, do it iteratively.

    `def reverse2(str)`

7. Determine if, given three strings, the first two strings can be interleaved to produce the third string. An interleaving is when the characters of two strings are combined in some order to produce a third string, but with the ordering of characters maintained.

 E.g., "abc" and "def" can be interleaved to make "adbecf". However, if you took away any letter, or changed the order to "acdfeb", it would no longer be a valid interleaving.

    `def is_interleaved?(str1, str2, maybe_interleaved_string)`

#### Super Crazy Bonus:

Read about and implement the [Boyer-Moore-Horspool text search algorithm](https://en.wikipedia.org/wiki/Boyer%E2%80%93Moore%E2%80%93Horspool_algorithm).

 Boyer-Moore-Horspool is the most common general-use string search algorithm, and it’s extremely fast for most practical text search requirements.

 Python, Java, Go, JavaScript (V8) and many other string search implementations use the Boyer-Moore-Horspool for text searching. Ruby actually used to use the Rabin-Karp algorithm, and it now uses a home-spun algorithm which is an adaptation of Knuth-Morris-Pratt. But generally speaking, Boyer-Moore-Horspool is the gold standard for general-purpose text search.
