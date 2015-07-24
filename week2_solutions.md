# Simple Knapsack Problem

```ruby
def knapsack(elements, target)

  # We create a matrix whose rows correspond to elements, and whose columns
  # correspond to element sums.

  knapsack_matrix = Array.new(elements.length + 1) { Array.new(target + 1) {0} }

  # Seed with 1... Corresponds to there being one way to come up with a
  # set of elements whose sum is 0 using 0 elements.
  knapsack_matrix[0][0] = 1

  # Now we go through the matrix and for each element, we look to see how we can add it to the
  # other sums of elements to create new sums.
  elements.each_with_index do |el, i|
    (1..target).each do |sum|
      knapsack_matrix[i + 1][sum] = knapsack_matrix[0..i].inject(0) do |acc, row|
        acc + (sum - el >= 0 ? row[sum - el] : 0)
      end
    end
  end

  # The last column represents our target value, so we sum all the values in the last column to
  # produce the solution!
  knapsack_matrix.inject(0) { |acc, row| acc + row.last }
end
```

# Rectangular sum

```ruby
class RectangleSummer
  def initialize(matrix)
    @sum_matrix = dp_sum(matrix)
  end

  def sum(x, y)
    @sum_matrix[y + 1][x + 1]
  end

  def rect_sum(upper_left, lower_right)
    sum(*lower_right) - sum(lower_right[0], upper_left[1] - 1) - sum(upper_left[0] - 1, lower_right[1]) + sum(upper_left[0] - 1, upper_left[1] - 1)
  end

  private

  def dp_sum(matrix)
    sum_matrix = Array.new(matrix.length + 1) { Array.new(matrix[0].length + 1) {0} }

    matrix.each_with_index do |row, i|
      row.each_with_index do |el, j|
        sum_matrix[i + 1][j + 1] = sum_matrix[i + 1][j] + sum_matrix[i][j + 1] - sum_matrix[i][j] + el
      end
    end

    sum_matrix
  end
end
```

# Boolean parenthesization

```ruby

# We need to create a helper function which will take a value (number of
# parenthesizations evaluating to true), a logical (symbol :and, :or, or
# :xor), a boolean (true or false), and the index of where we are in the
# dynamic programming matrix (which will give us the total number of possible
# parenthesizations), and which will return the number of parenthesizations
# evaluating to true, when including the new boolean.

def boolean_helper(value, logical, boolean, idx)
  total = 2 ** (idx - 2)
  case logical
  when :and
    boolean ? value : 0
  when :or
    boolean ? total : value
  when :xor
    boolean ? total - value : value
  end
end

def boolean_parens(token_string)
  token_string = token_string.downcase.gsub(" ", "")

  raise unless token_string =~ /\A([tf](and|or|xor))+[tf]\z/

  puts booleans = token_string.scan(/[tf]/).map { |letter| letter == 't' }
  puts logicals = token_string.scan(/(and|or|xor)/).map { |logical| logical.first.to_sym }

  dp_matrix = Array.new(booleans.length) { Array.new(booleans.length) }

  # initialize the matrix, using only the upper-right half, starting one step above the midline.

  logicals.each_with_index do |logical, i|
    dp_matrix[i][i + 1] = case logical
    when :and
      booleans[i] && booleans[i + 1] ? 1 : 0
    when :or
      booleans[i] || booleans[i + 1] ? 1 : 0
    when :xor
      (booleans[i] || booleans[i + 1]) && !(booleans[i] && booleans[i + 1]) ? 1 : 0
    end
  end

  (0...booleans.length).each do |i|
    (0..i - 2).to_a.reverse.each do |j|
      dp_matrix[j][i] = boolean_helper(dp_matrix[j][i - 1], logicals[i - 1], booleans[i], i) + boolean_helper(dp_matrix[j + 1][i], logicals[j], booleans[j], i - j)
    end
  end

  dp_matrix.first.last
end
```
