# MyHashMap
Today you will implement your very own HashMap. This may sound tricky,
but don't worry, it'll start to feel good after a while. Also, I've given you
specs. You'll be okay.

## Phase 1: IntSet
A set is a data type that can store unordered, unique items. Sets don't make
any promises regarding insertion order, and they won't store duplicates. In
exchange for those constraints, sets have remarkably fast retrieval time and
can quickly look up the presence of values.  

Many mathematicians claim that sets are the foundation of mathematics. So
basically, you're going to create all of mathematics. NBD.

A set is an **abstract data type**
([ADT](https://en.wikipedia.org/wiki/Abstract_data_type)). An ADT can
be thought of as a high-level description of a structure and API. But that
structure and API can be realized through different implementations. Examples of
ADTs are things like sets, maps,  Those
implementations are known as **data structures**. Different data structures can
implement the same abstract data type, but some are worse than
others. We're going to show you *the best* implementations, or close to them.

Sound cool yet? No? Too bad. Let's make a set.

### MaxIntSet
We'll start with the first stage. In this version of a set, we can only store
integers that live in a predefined range. So I tell you the maximum integer
I'll ever want to store, and you give me a set that can store it and any smaller
positive number.

- Initialize your MaxIntSet with an integer called `max` to define the range of
integers that we're keeping track of.
- Internal structure:
  - An array called `@store`, of length `max`
  - Each index in the `@store` will correspond to item, and the value at that
  index will correspond to its presence (either `true` or `false`)
  - e.g., the set `{ 0, 2, 3 }` will be stored as: `[true, false, true, true]`
  - The size of the array will remain constant!
- Methods:
  - `#insert`
  - `#remove`
  - `#include?`

Once you've built this and it works, we'll move on to the next iteration.

### IntSet
Now let's see if we can keep track of an arbitrary range of integers.
Here's where it gets interesting. Create a brand new class for this one.
We'll still initialize an array of a fixed length--say, 20. But now, instead of
each element being `true` or `false`, they'll each be sub-arrays.

Imagine the set as consisting of 20 buckets (the sub-arrays). When we insert
an integer into this set, we'll pick one of the 20 buckets where that integer
will live. That can be done easily with the modulo operator: `i = n % 20`.

Using this mapping, which wraps around once every 20 integers, every integer
will be deterministically assigned to a bucket. Using this concept, create your
new and improved set.

- Initialize an array of size 20, with each containing item being an empty
array.
- To look up a number in the set, modulo the number by the set's length, and
add it to the array at that index. If the integer is present in that bucket,
that's how we know it's included in the set.
- Your new set should be able to keep track of an arbitrary range of integers,
including negative integers. Test it out.

### ResizingIntSet
The IntSet is okay for small sample sizes. But if the number of elements grows
pretty big, our set's retrieval time depends more and more on an array lookup,
which is what we're trying to get away from. It's slow.

Scanning for an item in an array (when you don't know the index) takes `O(n)`
time, because you have to look at every item. So if we're having to do an array
scan on one of the 20 buckets, that bucket will have on average 1/20th of the
overall items. That gives us an overall time complexity of `O(0.05n)`. When you
strip out the 0.05 constant factor, that's still `O(n)`. Meh.

Let's see if we can do better.

- Make a new class. This time, let's increase the number of buckets as the size
of the set increases. The goal is to have `buckets.length > N` at all times.
- You might want to implement a simplified `#inspect` method to make debugging
easier.
- What are the time complexities of the operations of your set implementation?

**Once you're done, get a code review!**

## Phase 2: Hashing
A hash function is a sequence of mathematical operations that deterministically
maps any arbitrary data into a pre-defined range of values. Anything that does
that is a hash function. However, a *good* hash function satisfies the property
of being **uniform** in how it distributes that data over its range of values.
In other words, without knowing anything about the thing you're hashing, it
should be impossible to guess what its hash value will be.

To create a good hash function, we want to be able to hash absolutely anything.
That includes integers, strings, arrays, and even other hashes.

Remember, a hash function should be **deterministic**, meaning that it should
always produce the same value given the same input. It's also highly desirable
for equivalent objects to produce the same hash. So if we have two arrays,
each equal to [1, 2, 3], we want them both to hash to the same value.

So let's construct a nice hashing function that'll do that for us. Be creative
here!

Hint: you may want to look into bit-wise operators like [XOR][xor-info] (`^` in
Ruby).

[More reading on hash functions][hash-info].
- Write hash functions for `Array`, `String`, and `Hash`. Build these up
  sequentially.
  - Order is relevant for arrays and strings, but it's irrelevant for hashes.
    - Keep track of indices for arrays and strings.
    - One trick to make a hash function order-agnostic is to turn the object into
    an array, stably sort the array, and then hash the array. This'll make it so
    every unordered version of that same object will hash to the same value.

[hash-info]: https://en.wikipedia.org/wiki/Hash_function
[xor-info]: http://www.cs.umd.edu/class/sum2003/cmsc311/Notes/BitOp/xor.html

## Phase 3: HashSet
Now that we've got our hashing functions, we can store more than just
integers. Let's make it so we can store any data type in our set.

### 3a: MyHashSet
This will be a simple improvement on ResizingIntSet. Just hash every item before
performing any operation on it. This will return an integer, which you can
modulo by the number of buckets. With this simple construction, you set will be
able to handle keys of any data type.

Easy as pie. We now have a sexy, sexy set that works with any data type.

But let's take it one step further.

### 3b: MyHashMap
Up until now, our hash set has only been able to insert and then check for
inclusion. We couldn't create a map of values, as in key-value pairs. Let's
change that and create a **hash map**. But first, we'll have to build a
subsidiary underlying data structure.

## Phase 4: Linked List
A [linked list][linked-list-wiki] is a data structure which is consists of a
series of links. Each link consists of a value and a pointer to the next link
(or `null`). When referencing a linked list, all you have to do is point to the
first (or head) link, and you can then access the entirety of the list simply by
traversing the links.

Let's implement a Linked List for our hash buckets. Each link in your linked list
will need to store both a key and a value. Don't ask why, just trust me on this.

I've gotten you this far, haven't I?

If you're struggling to implement this, just think back to the TreeNode problems
you did. This is a similarly recursive data structure.

I've made the `Link` class for you. You'll notice I defined it using
`Struct.new`. `Struct` is a Ruby shortcut for creating an extremely simple object.
It just takes all of your arguments and defines `attr_accessors` for them, and
that's pretty much it. wrapper. For our purposes, our `Link` class doesn't require
any more than that, so it's perfect. The bulk of our logic will be in the
`LinkedList` class anyway.

Your linked list's methods:
- `#insert(key, val)`
- `#get(key)`
- `#include?(key)`
- `#remove(key)`

*Hint: any linked list method needs to check for two things: whether the head
is nil (meaning the list is empty), and whether you've reached a nil link
(meaning you've reached the tail of the linked list). Make sure that you
reassign the head if you ever remove it.*

Once you're done with those, we're going to also make your linked lists
enumerable. We want them to be just as flexible as arrays. Remember
back to when you wrote `#my_each`, and let's get this thing enumerating.
- Write `#each` for your linked list

Once you have `#each` defined, you can include the `Enumerable` module into your
class. As long as you have `each` defined, the `Enumerable`
module gives you `map`, `each_with_index`, `select`, `any?` and all of the other
enumeration methods for free!

## Phase 5: Hash Map (reprise)
So now let's incorporate our linked list into our hash buckets. Instead of having
each bucket be an array which we'll push items into, we'll have each bucket hold
a linked list. Each linked list will start out empty. But whenever we want to
insert an item into that bucket, we'll just tack it into the end of that linked
list.

So here again is a summary of how you use our hash map:
- Hash the key, mod by the number of buckets
- To **insert**, append that key and value to the linked list for that bucket
- To **get**, check whether that linked list contains the key you're looking up
- To **delete**, remove the link corresponding to that key from the linked list

Also make sure your hash map resizes! In order to resize properly, you have to
enumerate over each of your linked lists and re-hash their contents into your new
resized hash map. If you don't re-hash them, your hash map will be completely
broken. Can you see why?

Now pass those specs, space cowboy.

Once you're done, you should have a fully functioning hash map that can use
numbers, strings, arrays, or hashes as keys. Show off your awesomeness by asking
a TA for a **Code Review**.

[linked-list-wiki]: https://en.wikipedia.org/wiki/Linked_list
## Phase 5a: enumerable methods
Finally, let's make your hash map properly enumerable. You know the drill.
Implement `#each`, and then include the `Enumerable` module. Make your hash map
yield `[key, value]` as pairs the same way the Ruby hash does.
