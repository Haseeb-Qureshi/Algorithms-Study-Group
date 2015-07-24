# Week 2: Dynamic Programming with Matrices
##### Led by: [Joshua Penman](https://github.com/JoshuaSP/), currently on the infrastructure/stability team at [Asana](http://asana.com)
######Topics:
* What is dynamic programming?
* Dynamic programming vs. recursive solutions.
* General thoughts on setting up dynamic programming problems
* Example problem (find_path):

### EXAMPLE PROBLEM:

We are given a matrix, containing 0's and 1's.
Each 1 represents a square we can move to, and a 0 represents a square we cannot move to. If we start in the upper left corner, and we can only move down and to the right, how many ways are there to navigate to the bottom right corner?

```ruby
def find_path(matrix)
    # We initialize path_matrix, where each element is an integer representing
    # the total number of possible paths to that element.
  path_matrix = Array.new(matrix.length + 1) { Array.new(matrix[0].length + 1) {0} }

    # We set the element directly "over" the starting element of the original
    # matrix to 1, so as to give us an entry point.
  path_matrix[0][1] = 1

    # We then iterate through the starting matrix, filling in values of path_matrix
    # one at a time, depending on whether the starting matrix has a 1 or 0, and
    # how many paths are possible to the cell directly above and directly to
    # the left of the given cell.

    # Note that cells in path_matrix are indexed so that path_matrix[i + 1][j + 1]
    # corresponds to the cell matrix[i][j]
  matrix.each_with_index do |row, i|
    row.each_with_index do |el, j|
      path_matrix[i + 1][j + 1] = el == 0 ? 0 : path_matrix[i][j + 1] + path_matrix[i + 1][j]
    end
  end

  path_matrix.last.last
end

matrix = [
  [1, 1, 1, 0, 0, 1, 0],
  [1, 0, 1, 1, 1, 0, 1],
  [1, 0, 1, 1, 1, 1, 0],
  [1, 1, 1, 0, 1, 1, 1],
  [0, 1, 1, 1, 0, 1, 1],
  [0, 1, 1, 1, 0, 1, 0],
  [1, 0, 1, 1, 1, 1, 1],
]

puts find_path(matrix)  # == 17

```

### PROBLEM SET:

1. Simple knapsack problem: Given an array of elements, find the number of ways to select the elements (in a knapsack?) so that they sum exactly to the target.

    `def knapsack(elements, target)`

2. Rectangular sum. Given a matrix, find the sum of all values within a rectangle starting at the origin, and ending at a given coordinate.  Imagine that, with a given matrix, you will be asked this question repeatedly. The initial setup time for this problem will be `O(nm)` where n and m are the dimensions of the matrix. However, after this, lookup will be `O(1)`. Bonus: create a method that will return the sum within a rectangular region.

    ```ruby
      class RectangleSummer
        def initialize(matrix)
          @sum_matrix = dp_sum(matrix)
        end

        def sum(x, y)
          # your code here
        end

        def rect_sum(upper_left, lower_right)
          # your code here
        end

        private

        def dp_sum(matrix)
          # your code here
        end
      end
    ```

3. HARD/Bonus: How many ways are there to parenthesize a boolean expression (such as "T or F xor T and F") so that it evaluates to "True"?

  ```ruby
    def boolean_parens(token_string)
      token_string = token_string.downcase.gsub(" ", "")

      raise unless token_string =~ /\A([tf](and|or|xor))+[tf]\z/

      puts booleans = token_string.scan(/[tf]/).map { |letter| letter == 't' }
      puts logicals = token_string.scan(/(and|or|xor)/).map { |logical| logical.first.to_sym }

        # your code goes here

    end
  ```
