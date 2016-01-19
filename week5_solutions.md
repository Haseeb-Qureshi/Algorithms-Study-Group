```ruby
def lcs_length(str1, str2)
  lcs_table(str1, str2).last.last
end
```

```ruby
def lcs_table(str1, str2)
  str1, str2 = str1.downcase, str2.downcase
  dp = Array.new(str1.length + 1) { Array.new(str2.length + 1) { 0 } }

  1.upto(str1.length) do |i|
    1.upto(str2.length) do |j|
      if str1[i - 1] == str2[j - 1]
        dp[i][j] = dp[i - 1][j - 1] + 1
      else
        dp[i][j] = [dp[i][j - 1], dp[i - 1][j]].max
      end
    end
  end

  dp
end
```

```ruby
def lcs(str1, str2)
  table = lcs_table(str1, str2)
  i, j = str1.length - 1, str2.length - 1
  sequence = ""

  while i >= 0 && j >= 0
    if str1[i] == str2[j]
      sequence << str1[i]
      i -= 1
      j -= 1
    else
      current = table[i + 1][j + 1]
      left = table[i + 1][j]
      above = table[i][j + 1]

      if above && above == current
        i -= 1
      else
        j -= 1
      end
    end
  end

  sequence.reverse!
end
```

```ruby
EDIT_COSTS = {
  replace: 1,
  insert: 1,
  delete: 1,
}

def edit_distance(str1, str2)
  str1, str2 = str1.downcase, str2.downcase
  dp = Array.new(str1.length + 1) { Array.new(str2.length + 1) { 0 } }
  costs = EDIT_COSTS

  dp[0].map!.with_index { |_, i| i }
  dp.each_with_index { |arr, j| arr[0] = j }

  1.upto(str1.length) do |i|
    1.upto(str2.length) do |j|
      if str1[i - 1] == str2[j - 1]
        dp[i][j] = dp[i - 1][j - 1]
      else
        dp[i][j] = [
          costs[:insert] + dp[i][j - 1],
          costs[:delete] + dp[i - 1][j],
          costs[:replace] + dp[i - 1][j - 1]
        ].min
      end
    end
  end
  dp.last.last
end
```

```ruby
def autocorrect(str)
  dict = []
  File.foreach("dictionary.txt") { |line| dict << line.chomp if line[0] == str[0] }
  dict.min_by { |word| edit_distance(str, word) }
end
```
