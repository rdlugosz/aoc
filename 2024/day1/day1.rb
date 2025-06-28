#!/usr/bin/env ruby

# Need to read the file form the cmd line

@left  = []
@right = []
line_count = 0

ARGF.readlines.each do |line|
  a, b = line.split("   ")
  @left << a.chomp.to_i
  @right << b.chomp.to_i
  line_count += 1
end

@left.sort!
@right.sort!

def count_in_right(l_val, idx)
  @right.count(l_val)
end

distance = 0
similarity = 0
@left.each_with_index do |l_val, idx|
  r_val = @right[idx]
  puts "Index #{idx}, L: #{l_val}, R: #{r_val}"
  distance += (l_val - r_val).abs

  similarity += l_val * count_in_right(l_val, idx)
end

puts "Total distance: #{distance}. Similarity: #{similarity}. Total lines in file: #{line_count}"

