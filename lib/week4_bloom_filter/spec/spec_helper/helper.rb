def false_positive_rate(test_size, type)
  bf = type.new(test_size, 0.001)
  (0...test_size).each { |n| bf.insert(n) }
  false_positives = (test_size...test_size * 2).inject(0) do |count, n|
    count += 1 if bf.include?(n)
    count
  end
  false_positives.fdiv(test_size)
end
