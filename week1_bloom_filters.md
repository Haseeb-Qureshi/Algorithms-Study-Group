# Week 1: Bloom Filters
##### Led by: [Haseeb Qureshi](https://github.com/Haseeb-Qureshi/), instructor at [App Academy](http://appacademy.io)

######Topics:
* Word Processing and Windows 95
* What's a hash function?
* Hash map basics
* Hash map --> bitmap + multiple hash functions --> Bloom filter
* Network routers and database reads
* Time complexity
* Probabilistic data structure?
  * P(0|one hash insertion)
    * `1 - 1/m`
  * P(0|one element's insertion)
    * `P(0 after one hash insertion) ^ k`
    * `(1 - 1/m) ^ k`
  * P(0|N elements)
    * `P(0 after inserting one element) ^ N`
    * `(1 - 1/m) ^ (k*N)`
  * P(1|N elements)
    * `1 - P(0 after inserting N elements) `
    * `1 - (1 - 1/m) ^ (k*N)`
  * P(false positive|having inserted N elements)
    * `P(1 after inserting N elements) ^ k`
    * = `(1 - (1 - 1/m) ^ (k*N)) ^ k`
    * ≈ `(1 - e ^ (-kn/m)) ^ k`
* Optimal number of bits and hash functions (scary math)
  * num_bits: `-(capacity * ln(failure_rate)) / ln(2) ** 2`
  * num_hashes: `ln(2) * num_bits / capacity`
* Bells and whistles: clearing, merging
* Augmentation: scalable Bloom filter
* Review of the code!

### PROBLEM SET
###### Download this [Bloom filter skeleton](lib/week1_bloom_filter/skeleton.zip), bundle install, and start passing those specs!

##### BONUS:
Adapt your Bloom filter to become a [Counting Filter](https://en.wikipedia.org/wiki/Bloom_filter#Counting_filters). This will allow you to perform deletions! See if you can write a `delete` method for your counting filter.
