#!/usr/bin/env ruby
require "optparse"

@options = {}
OptionParser.new do |opts|
  opts.on("--binary_search") { @options[:binary_search] = true }
end.parse!

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
  if @options[:binary_search]
    first = find_first_instance(l_val, @right)
    return 0 unless first

    last = find_last_instance(l_val, @right)
    last - first + 1
  else
    @right.count(l_val)
  end
end

def find_first_instance(val, array)
  left, right = 0, array.size - 1
  result = nil

  while left <= right
    midpoint = (left + right) / 2
    if array[midpoint] == val
      result = midpoint
      right  = midpoint - 1
    elsif array[midpoint] < val
      left = midpoint + 1
    else
      right = midpoint - 1
    end
  end

  result
end

def find_last_instance(val, array)
  left, right = 0, array.size - 1
  result = nil

  while left <= right
    midpoint = (left + right) / 2
    if array[midpoint] == val
      result = midpoint
      left = midpoint + 1
    elsif array[midpoint] < val
      left = midpoint + 1
    else
      right = midpoint - 1
    end
  end

  result
end

distance   = 0
similarity = 0

@left.each_with_index do |l_val, idx|
  r_val = @right[idx]
  # puts "Index #{idx}, L: #{l_val}, R: #{r_val}"
  distance += (l_val - r_val).abs

  similarity += l_val * count_in_right(l_val, idx)
end

puts "Total distance: #{distance}. Similarity: #{similarity}. Total lines in file: #{line_count}"

# For reference, the correct solution should output:
# Total distance: 1110981. Similarity: 24869388. Total lines in file: 1000

