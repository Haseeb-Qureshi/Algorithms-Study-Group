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

2. You should get `lcs_length(str1, str2)` for free. Now write your `lcs(str1, str2)` method by tracing backwards through the matrix, retracing your steps. Start with pointers `i = str1.length, j = str2.length` and walk backwards through the matrix. Any time you move diagonally, that means that both strings shared that letter, and you should add it to the sequence you're building up.

At the end, reverse the sequence, and viola!

3. Now try to build your `edit_distance(str1, str2)` method to calculate the Levenshtein edit distance. I've given you the edit costs, which will make your code more semantic (and will allow you to adapt it to different edit distance measures).

Remember, you want to take the *minimum* of the three possible operation costs. The code should look fairly similar to your LCS, but not entirely the same.

### BONUS:

Implement an auto-correct function. Taking in a string, return the closest match within a dictionary. I've provided you a dictionary.
