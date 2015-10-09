# Week 7: Edit Distance
##### Led by: [Haseeb Qureshi](https://github.com/Haseeb-Qureshi/), instructor at [App Academy](http://appacademy.io)

######Topics:
* git diff & autocomplete
* Dynamic Programming revisited
* More matrices!
* Longest Common Substring => git diff
* Edit distance
* Levenshtein Edit Distance with Matrices
* Make your own!

### PROBLEM SET:

##### Download [this skeleton](lib/week7_edit_distance/skeleton.zip), bundle install, and start passing those specs!

1. Start by writing `lcs_table(str1, str2)` which constructs your Dynamic Programming table. You will use this to both find the length of the LCS, as well as to reconstruct it.

Your matrix should be of dimensions `str1.length + 1, str2.length + 1`. This is so that you can initialize the longest common subsequence with the empty string. (These are always `0`, of course, so fill up the matrix accordingly.)

Now go up from `1 to str1.length`, and inside a nested loop, `1 to str2.length`.

If the characters match (should be `i - 1` and `j - 1` because your matrix is extra big by `1` -- matrix dynamic programming is often tricky w/ the indices), then the LCS should increment by one over the adjacent upper left diagonal.

Otherwise, just copy the greater LCS of the guy to your left, or above you.

Then end the loop, return your DP array.

2. You should get `lcs_length(str1, str2)` for free. Now write your `lcs(str1, str2)` method by tracing backwards through the matrix, retracing your steps. Start with pointers `i = str1.length, j = str2.length` and walk backwards through the matrix. Any time you move diagonally, that means that both strings shared that letter, and you should add it to the sequence you're building up. Otherwise, trace back your indices through an adjacent, equivalent number.

At the end, reverse the sequence, and viola!

3. Now try to build your `edit_distance(str1, str2)` method to calculate the Levenshtein edit distance. I've given you the edit costs, which will make your code more semantic (and will allow you to adapt it to different edit distance measures).

Remember, you want to take the *minimum* of the three possible operation costs. The code should look fairly similar to your LCS, but not entirely the same.

Again, the dimensions should be `str1.length + 1, str2.length + 1`. But in this case, your first row should be initialized with `(0...str1.length)`, and your first column should be `(0...str2.length)`. Try to reason why this is is the case.

Then same this as before, `1.upto(str1.length)`, `1.upto(str2.length)`. But the rules are a little bit different from how you add up the costs. Figure this out! Remember, you should always be able to use the 3 adjacent cells to calculate the edit distance.

### BONUS:

Implement an auto-correct function. Taking in a string, return the closest match within a dictionary. I've provided you the dictionary.
