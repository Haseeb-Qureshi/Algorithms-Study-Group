def lcs_table(str1, str2)
  # Create your DP matrix in here.
end

def lcs_length(str1, str2)
  # lcs_table(str1, str2).last.last <== This will select the bottom right cell of your DP matrix, which should be the longest subsequence length
end

def lcs(str1, str2)
  # actually generate the LCS! Work backwards from your DP matrix.
end

EDIT_COSTS = {
  replace: 1,
  insert: 1,
  delete: 1,
}

def edit_distance(str1, str2)
  costs = EDIT_COSTS
  # Figure out the Levenshtein distance between these two strings!
end

def autocorrect(str)
  File.foreach("dictionary.txt") { |line| nil }
  # Do stuff in here to create your autocorrect method! I've given you a dictionary.
end
