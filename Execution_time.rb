def my_min(list)
#    smallest = list.first
#    list.each_with_index do |ele1, i|
#        (i...list.size).each do |j|
#            if smallest > list[j]
#                smallest = list[j]
#            end
#        end
#    end
#    smallest

    smallest = list.first
    list.each do |ele|
        smallest = [smallest, ele].min
    end
    smallest
end

def largest_contiguous_subsum(list)
#    subsums = []
#    list.each_with_index do |ele1, i|
#        (i...list.size).each do |j|
#            subsums << list[i..j].sum
#        end
#    end
#    subsums.max
    largest = list.first
    current = 0
    list[1..-1].each_with_index do |ele, i|
        current += ele
        largest = current if current > largest
        current = 0 if current < 0
    end
    largest
end


list = [5, 3, -7]
p largest_contiguous_subsum(list) # => 8

# possible sub-sums
[5]           # => 5
[5, 3]        # => 8 --> we want this one
[5, 3, -7]    # => 1
[3]           # => 3
[3, -7]       # => -4
[-7]          # => -7

list = [2, 3, -6, 7, -6, 7]
p largest_contiguous_subsum(list) # => 8 (from [7, -6, 7])
list = [-5, -1, -3]
p largest_contiguous_subsum(list) # => -1 (from [-1])

#list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
#p my_min(list)  # =>  -5

